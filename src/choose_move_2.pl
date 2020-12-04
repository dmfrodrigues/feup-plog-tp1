% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('utils.pl'),
    reconsult('choose_move_common.pl').

:-
    ((current_predicate(base_directory/1), base_directory(_)) -> true ; 
        (
            current_working_directory(CWD),
            BASE = CWD,
            assert(base_directory(BASE))
        )
    ).

/**
 * valid_move_from_action2(+Board, +playermove_action2(NewPos), -playermove(Turn, Pos, Substacks, Dir, NewPos))
 * 
 * Given the second action of a move, find any complete move with that second action
 * which is valid in a certain Board.
 */
valid_move_from_action2(
  Board,
  playermove_action2(NewPos),
  playermove(Turn, Pos, Substacks, Dir, NewPos)
) :-
    move(Board, playermove(Turn, Pos, Substacks, Dir, NewPos), _).

/**
 * valid_moves_action2(+Board, +Turn, -ListOfMoves)
 * 
 * Find valid moves that vary in action 2, using for action 1 the first valid move
 */
valid_moves_action2(Board, Turn, ListOfMoves) :-
    setof(
        playermove_action2(NewPos),
        Pos^Substacks^Dir^NewPos^NewBoard^move(Board, playermove(Turn, Pos, Substacks, Dir, NewPos), NewBoard),
        ListOfAction2
    ),
    length(ListOfAction2, L),
    list_create(Board, L, Boards),
    maplist(valid_move_from_action2, Boards, ListOfAction2, ListOfMoves).

/**
 * expand_valid_move_action2(+gamestate(Board, Turn), +M, -Expanded)
 * 
 * Expand move by varying action 1.
 */
expand_valid_move_action2(
  gamestate(Board, Turn),
  playermove(_, _, _, _, NewPos),
  Expanded
) :-
    findall(
        playermove(Turn, Pos1, Substacks1, Dir1, NewPos),
        move(Board, playermove(Turn, Pos1, Substacks1, Dir1, NewPos), _),
        Expanded
    ).

/**
 * expand_valid_moves_action2(+gamestate(Board, Turn), +Moves, -Expanded)
 * 
 * Expand the moves in Moves, by using all possible values for Pos,Substacks,Dir
 */
expand_valid_moves_action2(_, [], []).
expand_valid_moves_action2(gamestate(Board, Turn), [M|Moves], Expanded) :-
    expand_valid_moves_action2(gamestate(Board, Turn), Moves, Expanded1),
    expand_valid_move_action2(gamestate(Board, Turn), M, Expanded2),
    append(Expanded1, Expanded2, Expanded).

/**
 * best_opponent_move2(+gamestate(Board, Turn), +Move, +Level, -(Value-Move))
 * 
 * Given a board and the current player's move, determine the best move
 * the opponent could make for himself, and return a Value-Move pair
 * where Value is the final value after Level levels of optimal choices
 */
best_opponent_move2(gamestate(Board, Turn), Move, Level, Value-Move) :-
    move(Board, Move, NewBoard),
    next_player(Turn, NewTurn),
    Level1 is Level-1,
    choose_move_2(gamestate(NewBoard, NewTurn), NewTurn, Level1, 1, _, Value).

/*
 * choose_move_2(+GameState, +Turn, +Level, +N, -Move, -Value)
 *
 * Choose best move for player Turn in GameState.
 * 
 * To compute the best move, the predicate will go Level levels into the decision tree:
 * Level=0: Explore direct moves
 * Level=1: Explore direct moves and antecipate adversary move (one full round)
 * Level=2: Explore direct moves, antecipate adversary move and perform another move
 * Level=3: Explore direct moves, antecipate adversary move, perform another move and anticipate adversary again (two full rounds)
 * ...
 * 
 * To compute the best move, the predicate will at each stage:
 * - Get all valid options for action 2
 * - Choose the N best of those options (using the first valid value for Pos,Substacks,Dir)
 * - Get all valid moves based on those N options for action 2
 * - If Level=0, get the best of those moves
 * - If Level=1, select the N best moves, and explore those moves in depth (providing N=1 for a full greedy strategy)
 * 
 * Thus, on the first level this predicate is semi-greedy given it chooses the N best moves
 * to carry to the next step; on the following levels, N=1 and as thus this predicate is full greedy.
 *
 * Both Level and N determine the quality of the final answer.
 * However, it is expected Level influences result quality the most,
 * as N is only intended to be a tuning variable, whose value can be chosen
 * to allow reducing the computation time.
*/
choose_move_2(gamestate(Board, Turn), Turn, 0, N, Move, Value) :- !,
    valid_moves_action2(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves),
    expand_valid_moves_action2(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_move(gamestate(Board, Turn), ListOfBestMovesExpanded, Move, Value).

choose_move_2(gamestate(Board, Turn), Turn, Level, N, Move, Value) :-
    valid_moves_action2(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves),
    expand_valid_moves_action2(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_N_moves(gamestate(Board, Turn), ListOfBestMovesExpanded, N, ListOfBestestMoves),
    list_create(gamestate(Board, Turn), N, GameStates),
    list_create(Level, N, Levels),

    base_directory(BASE),
    (
        (current_prolog_flag(dialect, sicstus), atom_concat(BASE, 'obj/choose_move_2.po', CHOOSE_MOVE_2));
        (current_prolog_flag(dialect, swi    ), atom_concat(BASE, 'src/choose_move_2.pl', CHOOSE_MOVE_2))
    ),
    (N =:= 1 -> Nthreads is 1 ; Nthreads is 12),
    maplist_multi(
        (
            (
                (current_prolog_flag(dialect, sicstus), load_files([CHOOSE_MOVE_2]));
                (current_prolog_flag(dialect, swi    ), reconsult(CHOOSE_MOVE_2))
            ),
            assert(base_directory(BASE))
        ),
        Nthreads,
        best_opponent_move2,
        GameStates,
        ListOfBestestMoves,
        Levels,
        Result
    ),

    /*
    maplist(
        best_opponent_move2,
        GameStates,
        ListOfBestestMoves,
        Levels,
        Result
    ),
    */

    (Turn =:= 1 -> min_member(Value-Move, Result) ; max_member(Value-Move, Result)).

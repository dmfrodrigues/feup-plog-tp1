:-
    reconsult('valid_moves.pl'),
    reconsult('choose_move_common.pl').

/**
 * valid_move_from_action2(+Board, +playermove_action2(NewPos), -playermove(Turn, Pos, Substacks, Dir, NewPos))
 * 
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
 */
expand_valid_moves_action2(_, [], []).
expand_valid_moves_action2(gamestate(Board, Turn), [M|Moves], Expanded) :-
    expand_valid_moves_action2(gamestate(Board, Turn), Moves, Expanded1),
    expand_valid_move_action2(gamestate(Board, Turn), M, Expanded2),
    append(Expanded1, Expanded2, Expanded).

/**
 * best_opponent_move2(+gamestate(Board, Turn), +Move, +Level, -(Value-Move))
 * 
 */
best_opponent_move2(gamestate(Board, Turn), Move, Level, Value-Move) :-
    move(Board, Move, NewBoard),
    next_player(Turn, NewTurn),
    Level1 is Level-1,
    choose_move_2(gamestate(NewBoard, NewTurn), NewTurn, Level1, 1, _, Value).

/*
 * choose_move_2(+GameState, +Turn, +Level, +N, -Move, -Value)
 *
*/
choose_move_2(gamestate(Board, Turn), Turn, 0, N, Move, Value) :-
    valid_moves_action2(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves),

    expand_valid_moves_action2(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_move(gamestate(Board, Turn), ListOfBestMovesExpanded, Move, Value).

choose_move_2(gamestate(Board, Turn), Turn, Level, N, Move, Value) :-
    valid_moves_action1(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves),

    expand_valid_moves_action2(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_N_moves(gamestate(Board, Turn), ListOfBestMovesExpanded, N, ListOfBestestMoves),
    list_create(gamestate(Board, Turn), N, GameStates),
    list_create(Level, N, Levels),
    maplist(best_opponent_move2, GameStates, ListOfBestestMoves, Levels, Result),
    (Turn =:= 1 -> min_member(Value-Move, Result) ; max_member(Value-Move, Result)).

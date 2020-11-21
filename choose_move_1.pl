:-
    reconsult('valid_moves.pl'),
    reconsult('choose_move_common.pl').

/**
 * valid_move_from_action1(+Board, +playermove_action1(Turn, Pos, Substacks, Dir), -playermove(Turn, Pos, Substacks, Dir, NewPos))
 * 
 * Given the first action of a move, find any complete move with that first action
 * which is valid in a certain Board.
 */
valid_move_from_action1(
  Board,
  playermove_action1(Turn, Pos, Substacks, Dir),
  playermove(Turn, Pos, Substacks, Dir, NewPos)
) :-
    move(Board, playermove(Turn, Pos, Substacks, Dir, NewPos), _).
  
/**
 * valid_moves_action1(+Board, +Turn, -ListOfMoves)
 * 
 * Find valid moves that vary in action 1, using for action 2 the first valid move
 */
valid_moves_action1(Board, Turn, ListOfMoves) :-
    setof(
        playermove_action1(Turn, Pos, Substacks, Dir),
        Pos^Substacks^Dir^NewPos^NewBoard^move(Board, playermove(Turn, Pos, Substacks, Dir, NewPos), NewBoard),
        ListOfAction1
    ),
    length(ListOfAction1, L),
    list_create(Board, L, Boards),
    maplist(valid_move_from_action1, Boards, ListOfAction1, ListOfMoves).

/**
 * expand_valid_move_action1(+gamestate(Board, Turn), +M, -Expanded)
 * 
 * Expand move by varying action 2.
 */
expand_valid_move_action1(
  gamestate(Board, Turn),
  playermove(Turn, Pos, Substacks, Dir, _),
  Expanded
) :-
    findall(
        playermove(Turn, Pos, Substacks, Dir, NewPos1),
        move(Board, playermove(Turn, Pos, Substacks, Dir, NewPos1), _),
        Expanded
    ).

/**
 * expand_valid_moves_action1(+gamestate(Board, Turn), +Moves, -Expanded)
 * 
 * Expand the moves in Moves, by using all possible values for NewPos
 */
expand_valid_moves_action1(_, [], []).
expand_valid_moves_action1(gamestate(Board, Turn), [M|Moves], Expanded) :-
    expand_valid_moves_action1(gamestate(Board, Turn), Moves, Expanded1),
    expand_valid_move_action1(gamestate(Board, Turn), M, Expanded2),
    append(Expanded1, Expanded2, Expanded).

best_submove(gamestate(Board, Turn), Move, Level, Value-Move) :-
    move(Board, Move, NewBoard),
    next_player(Turn, NewTurn),
    Level1 is Level-1,
    choose_move_1(gamestate(NewBoard, NewTurn), NewTurn, Level1, 1, _, Value).

choose_move_1(gamestate(Board, Turn), Turn, 0, N, Move, Value) :- !,
    valid_moves_action1(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves),
    expand_valid_moves_action1(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_move(gamestate(Board, Turn), ListOfBestMovesExpanded, Move, Value).

choose_move_1(gamestate(Board, Turn), Turn, Level, N, Move, Value) :-
    valid_moves_action1(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves),
    expand_valid_moves_action1(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_N_moves(gamestate(Board, Turn), ListOfBestMovesExpanded, N, ListOfBestestMoves),
    list_create(gamestate(Board, Turn), N, GameStates),
    list_create(Level, N, Levels),
    maplist(best_submove, GameStates, ListOfBestestMoves, Levels, Result),
    (Turn =:=1 -> min_member(Value-Move, Result) ; max_member(Value-Move, Result)).

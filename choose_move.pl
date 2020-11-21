:-
    reconsult('valid_moves.pl').

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
 * choose_move(+GameState, +Player, +Level, -Move)
 * 
 * Choose best move, using a certain level of difficulty
 */
choose_move(gamestate(Board, Turn), Turn, Level, Move) :-
    choose_move_1(gamestate(Board, Turn), Turn, Level, Move).

choose_move_1(gamestate(Board, Turn), Turn, Level, Move) :-
    valid_moves_action1(Board, Turn, ListOfMoves),
    best_N_moves(gamestate(Board, Turn), Level, ListOfMoves, 5, ListOfBestMoves),
    expand_valid_moves_action1(gamestate(Board, Turn), ListOfBestMoves, ListOfBestMovesExpanded),
    best_move(gamestate(Board, Turn), Level, ListOfBestMovesExpanded, Move).

/**
 * get_move_value_pair(+gamestate(Board, Player), +Move, -(V-Move))
 * 
 * Gets value of board after performing Move, and returns a value-move pair.
 *
 * To be used in best_N_moves.
 */
get_move_value_pair(gamestate(Board, Player), Move, V-Move) :-
    move(Board, Move, NewBoard),
    value(gamestate(NewBoard, Player), Player, V1),
    (Player =:= 1 -> V is -V1 ; V is V1).

/**
 * best_N_moves(+gamestate(Board, Turn), +Level, +ListOfMoves, +N, -ListOfBestMoves)
 * 
 * Get the best N moves from ListOfMoves
 */
best_N_moves(gamestate(Board, Turn), Level, ListOfMoves, N, ListOfBestMoves) :-
    length(ListOfMoves, L),
    list_create(gamestate(Board,Turn), L, GameStates),
    maplist(get_move_value_pair, GameStates, ListOfMoves, ListOfMovesPairs),
    keysort(ListOfMovesPairs, SortedListOfMovesPairs),
    take(SortedListOfMovesPairs, N, ListOfBestMovesPairs),
    pairs_values(ListOfBestMovesPairs, ListOfBestMoves).

/**
 * best_move(+GameState, +Level, +ListOfMoves, -BestMove)
 * 
 * Choose best move from list.
 */
best_move(gamestate(Board, Turn), Level, [X|ListOfMoves], Move) :-
    Level1 is Level-1,
    best_move_(gamestate(Board, Turn), Level1, [X|ListOfMoves], Move, _).

/**
 * best_move_(+GameState, +Level, +ListOfMoves, -Move, -Value)
 * 
 * Get best move from list, where best move so far is Move, with value Value
 */
best_move_(gamestate(Board, Turn), Level, [X], X, V) :-
    !,
    value_greedy(gamestate(Board, Turn), Level, X, V).
best_move_(gamestate(Board, Turn), Level, [X1|ListOfMoves], X, V) :-
    % To the right
    best_move_(gamestate(Board, Turn), Level, ListOfMoves, X2, V2),
    % Current element
    best_move_(gamestate(Board, Turn), Level, [X1], X1, V1),
    % Evaluate
    (
        (Turn =:= 1,
            (V2 > V1 ->
                (X = X2, V is V2) ;
                (X = X1, V is V1)
            )
        );
        (Turn =:= 2,
            (V2 < V1 ->
                (X = X2, V is V2) ;
                (X = X1, V is V1)
            )
        )
    ).

/**
 * value_greedy(+gamestate(Board, Turn), +Level, +Move, -Value)
 * 
 * Goes Level levels down the possible plays tree
 */
value_greedy(gamestate(Board, Turn), 0, Move, Value) :-
    move(Board, Move, NewBoard),
    next_player(Turn, Turn1),
    value(gamestate(NewBoard, Turn1), Turn, Value).

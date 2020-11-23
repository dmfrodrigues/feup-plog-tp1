:-
    reconsult('utils.pl'),
    reconsult('valid_moves.pl').

:-
    reconsult('value.pl').

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
best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves) :-
    length(ListOfMoves, L),
    list_create(gamestate(Board,Turn), L, GameStates),
    (L >= 512 -> 
        (
            base_directory(BASE),
            atom_concat(BASE, 'choose_move_common.pl', CHOOSE_MOVE_COMMON),
            maplist_multi(
                (
                    reconsult(CHOOSE_MOVE_COMMON),
                    assert(base_directory(BASE))
                ),
                8,
                get_move_value_pair,
                GameStates,
                ListOfMoves,
                ListOfMovesPairs
            )
        );
        (
            maplist(
                get_move_value_pair,
                GameStates,
                ListOfMoves,
                ListOfMovesPairs
            )
        )
    ),
    keysort(ListOfMovesPairs, SortedListOfMovesPairs),
    take(SortedListOfMovesPairs, N, ListOfBestMovesPairs),
    pairs_values(ListOfBestMovesPairs, ListOfBestMoves).

/**
 * best_move(+GameState, +ListOfMoves, -BestMove, -BestValue)
 * 
 * Choose best move from list.
 */
best_move(gamestate(Board, Turn), ListOfMoves, Move, Value) :-
    best_move_(gamestate(Board, Turn), ListOfMoves, Move, Value).

/**
 * best_move_(+GameState, +ListOfMoves, -Move, -Value)
 * 
 * Get best move from list, where best move so far is Move, with value Value
 */
best_move_(gamestate(Board, Turn), [X], X, V) :-
    !,
    move(Board, X, NewBoard),
    next_player(Turn, Turn1),
    value(gamestate(NewBoard, Turn1), Turn, V).
best_move_(gamestate(Board, Turn), [X1|ListOfMoves], X, V) :-
    % To the right
    best_move_(gamestate(Board, Turn), ListOfMoves, X2, V2),
    % Current element
    best_move_(gamestate(Board, Turn), [X1], X1, V1),
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

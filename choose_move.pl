:-
    reconsult('valid_moves.pl').

/**
 * choose_move(+GameState, +Player, +Level, -Move)
 * 
 * Choose best move, using a certain level of difficulty
 */
choose_move(gamestate(Board, Turn), Turn, 1, Move) :-
    valid_moves(gamestate(Board, Turn), Turn, ListOfMoves),
    best_move(gamestate(Board, Turn), ListOfMoves, Move).

/**
 * best_move(+GameState, +ListOfMoves, -BestMove)
 * 
 * Choose best move from list.
 */
best_move(gamestate(Board, Turn), [X|ListOfMoves], Move) :-
    best_move_(gamestate(Board, Turn), [X|ListOfMoves], Move, _).

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

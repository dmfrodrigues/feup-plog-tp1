:-
    reconsult('valid_moves.pl').

/**
 * choose_move(+GameState, +Player, +Level, -Move)
 * 
 * Choose best move, using a certain level of difficulty
 */
choose_move(gamestate(Board, Turn), Turn, Level, Move) :-
    valid_moves(gamestate(Board, Turn), Turn, ListOfMoves),
    best_move(gamestate(Board, Turn), Level, ListOfMoves, Move).

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

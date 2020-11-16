:-
    reconsult('valid_moves.pl').

/**
 * choose_move(+GameState, +Player, +Level, -Move)
 * 
 * Choose best move, using a certain level of difficulty
 */
choose_move(gamestate(Board, Turn), Turn, 1, Move) :-
    valid_moves(gamestate(Board, Turn), Turn, ListOfMoves),
    best_move(gamestate(Board, Turn), ListOfMoves, Move)

/**
 * best_move(+GameState, +ListOfMoves, -BestMove)
 * 
 * Choose best move from list.
 */
best_move(gamestate(Board, Turn), [X|ListOfMoves], Move) :-
    move(Board, X, NewBoard),
    (Turn =:= 1 -> Turn1 is 2 ; Turn1 is 1),
    value(gamestate(NewBoard, Turn1), Turn, V),
    best_move_(gamestate(Board, Turn), [X|ListOfMoves], Move, V).

/**
 * best_move_(+GameState, +ListOfMoves, -Move, -Value)
 * 
 * Get best move from list, where best move so far is Move, with value Value
 */
best_move_(gamestate(Board, Turn), [X], X, V) :-
    !,
    move(Board, X, NewBoard),
    (Turn =:= 1 -> Turn1 is 2 ; Turn1 is 1),
    value(gamestate(NewBoard, Turn1), Turn, V).
best_move_(gamestate(Board, Turn), [X|ListOfMoves], X, V) :-
    % To the right
    best_move_(gamestate(Board, Turn), ListOfMoves, _, V1),
    % Current element
    move(Board, X, NewBoard),
    (Turn =:= 1 -> Turn1 is 2 ; Turn1 is 1),
    value(gamestate(NewBoard, Turn1), Turn, V),
    % Evaluate
    (
        (Turn =:= 1, V >= V1);
        (Turn =:= 2, V =< V1)    
    ),
    !.
best_move_(gamestate(Board, Turn), [_|ListOfMoves], X, V) :-
    best_move_(gamestate(Board, Turn), ListOfMoves, X, V).

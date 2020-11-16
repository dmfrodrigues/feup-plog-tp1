/**
 * value(+GameState, +Player, -Value).
 * 
 * Evaluates the GameState for the Player. If Value is positive, player 1 has the advantage,
 * if Value is negative, player 2 has the advantage.
 */
value(gamestate(Board, _), 1, 999999) :-
    game_over(gamestate(Board, _), 1), !.

value(gamestate(Board, _), 2, -999999) :-
    game_over(gamestate(Board, _), 2), !.

value(gamestate(Board, _), Player, Value) :-
    value_(Board, 0-0, V0),
    value_(Board, 0-1, V1),
    value_(Board, 0-2, V2),
    value_(Board, 0-3, V3),
    value_(Board, 0-4, V4),
    value_(Board, 1-5, V5),
    value_(Board, 2-6, V6),
    value_(Board, 3-7, V7),
    value_(Board, 4-8, V8),
    Value is V0+V1+V2+V3+V4+V5+V6+V7+V8.

value_(Board, I-J, Value):-
    board(Board, I-J, N),
    cell_value(I-J, N, V),
    NI is I + 1,
    value_(Board, NI-J, NV),
    Value is V + NV,
    !.

value_(Board, _, 0).

/**
 * cell_value(+Pos, +N, -Value).
 * 
 * Evaluates a specific cell.
 */
cell_value(I-J, N, V) :- position_value(I-J, F), V is F*N.

/**
 * position_value(+Pos, -Value)
 * 
 * Value of position
 */
position_value(I-J, 1) :-
    I=:=0; J=:=0; I=:=8; J=:=8; abs(I-J) =:= 4. 
    
position_value(I-J, 2) :-
    I=:=1; J=:=1; I=:=7; J=:=7; abs(I-J) =:= 3.

position_value(I-J, 3) :-
    I=:=2; J=:=2; I=:=6; J=:=6; abs(I-J) =:= 2.

position_value(I-J, 4) :-
    I=:=3; J=:=3; I=:=5; J=:=5; abs(I-J) =:= 1.

position_value(4-4, 5).

position_value(I-J, 0).

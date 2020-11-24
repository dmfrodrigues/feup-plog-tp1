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

value(gamestate([L0, L1, L2, L3, L4, [P0|L5], [P1,P2|L6], [P0,P1,P2|L7], [P0,P1,P2,P3|L8]], _), _, Value) :-
    GameState = gamestate([L0, L1, L2, L3, L4, [P0|L5], [P1,P2|L6], [P0,P1,P2|L7], [P0,P1,P2,P3|L8]], _),
    value_line(GameState, L0, 0-0, V0),
    value_line(GameState, L1, 1-0, V1),
    value_line(GameState, L2, 2-0, V2),
    value_line(GameState, L3, 3-0, V3),
    value_line(GameState, L4, 4-0, V4),
    value_line(GameState, L5, 5-1, V5),
    value_line(GameState, L6, 6-2, V6),
    value_line(GameState, L7, 7-3, V7),
    value_line(GameState, L8, 8-4, V8),
    Value is V0+V1+V2+V3+V4+V5+V6+V7+V8.

value_line(_, _, I-J, 0) :-            % End of line
    J > min(8, 4+I), !.
value_line(GameState, [N|Line], I-J, Value):-  % Valid position
    % Next values
    J1 is J+1,
    value_line(GameState, Line, I-J1, Value1),
    % Current value
    position_value(I-J, F1),
    adjacent_to_another_stack(GameState, I-J, F2),
    (N =:= 0 ->
    Value2 is 0; Value2 is F1 + abs(N)**0.8 + 2 + abs(F2)),
    (N < 0 ->
    (Value is Value1 - Value2); (Value is Value1 + Value2)).

/**
 * position_value(+Pos, -Value)
 * 
 * Value of position
 */
position_value(I-J, 1) :-
    I=:=0; J=:=0; I=:=8; J=:=8; abs(I-J) =:= 4. 
    
position_value(I-J, 2) :-
    I=:=1; J=:=1; I=:=7; J=:=7; abs(I-J) =:= 3.

position_value(I-J, 2) :-
    I=:=2; J=:=2; I=:=6; J=:=6; abs(I-J) =:= 2.

position_value(I-J, 3) :-
    I=:=3; J=:=3; I=:=5; J=:=5; abs(I-J) =:= 1.

position_value(4-4, 4).

position_value(_, 0).

/**
 * adjacent_to_another_stack(+GameState, +Pos, -Value)
 * 
 * Verifies if the stack in Pos is adjacent to another one of the
 * same player.
 */
adjacent_to_another_stack(gamestate(Board, _), I1-J1, Value):-
    isControlledByPlayer(Board, P, I1-J1),
    isAdj(I1-J1, I2-J2),
    isControlledByPlayer(Board, P, I2-J2),
    (P = 1 -> Value is 2; Value is -2),
    !.
adjacent_to_another_stack(_, _, 0).

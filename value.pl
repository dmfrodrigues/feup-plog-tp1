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

value(gamestate([L0, L1, L2, L3, L4, [_|L5], [_,_|L6], [_,_,_|L7], [_,_,_,_|L8]], _), _, Value) :-
    value_line(L0, 0-0, V0),
    value_line(L1, 1-0, V1),
    value_line(L2, 2-0, V2),
    value_line(L3, 3-0, V3),
    value_line(L4, 4-0, V4),
    value_line(L5, 5-1, V5),
    value_line(L6, 6-2, V6),
    value_line(L7, 7-3, V7),
    value_line(L8, 8-4, V8),
    Value is V0+V1+V2+V3+V4+V5+V6+V7+V8.

value_line(_, I-J, 0) :-            % End of line
    J > min(8, 4+I), !.
value_line([N|Line], I-J, Value):-  % Valid position
    % Next values
    J1 is J+1,
    value_line(Line, I-J1, Value1),
    % Current value
    position_value(I-J, F),
    (N =:= 0 ->
    Value2 is 0; Value2 is F+(abs(N)**0.8 + 2)),
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

position_value(I-J, 3) :-
    I=:=2; J=:=2; I=:=6; J=:=6; abs(I-J) =:= 2.

position_value(I-J, 2) :-
    I=:=3; J=:=3; I=:=5; J=:=5; abs(I-J) =:= 1.

position_value(4-4, 3).

position_value(_, 0).

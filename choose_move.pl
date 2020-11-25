% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('choose_move_1.pl'),
    reconsult('choose_move_2.pl').


/**
 * choose_move(+GameState, +Player, +Level, -Move)
 * 
 * Choose best move, using a certain level of difficulty
 */
choose_move(gamestate(Board, Turn), Turn, Level, N, Move) :-
    choose_move_1(gamestate(Board, Turn), Turn, Level, N, Move1, Value1),
    choose_move_2(gamestate(Board, Turn), Turn, Level, N, Move2, Value2),
    (
     (
      (Turn =:= 1, Value1 >= Value2);
      (Turn =:= 2, Value1 =< Value2)
     )->
        Move = Move1 ;
        Move = Move2
    ).

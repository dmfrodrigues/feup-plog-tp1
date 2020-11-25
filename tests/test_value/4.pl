% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(gamestate(InitialBoard,_)),
    move(InitialBoard, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    GameState = gamestate(NewBoard, 2),
    value(GameState, 1, V),
    V =:= 5.000000000000001,
    halt(0).
:-  halt(1).

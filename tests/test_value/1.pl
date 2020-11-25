% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(GameState),
    value(GameState, 1, V1), 
    value(GameState, 2, V2),
    V1 =:= 0.0,
    V2 =:= 0.0,
    halt(0).
:-  halt(1).

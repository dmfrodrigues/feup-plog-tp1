% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../src/game_over.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

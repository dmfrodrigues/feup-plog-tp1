% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../game_over.pl'),
    reconsult('../../sample-states/intermediate_state.pl'),
    intermediate_state(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/final_state.pl'),
    final_state(GameState),
    value(GameState, 1, 999999),
    halt(0).
:-  halt(1).

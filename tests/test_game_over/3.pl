% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../game_over.pl'),
    reconsult('../../sample-states/final_state.pl'),
    final_state(GameState),
    game_over(GameState, 1),
    halt(0).
:-  halt(1).

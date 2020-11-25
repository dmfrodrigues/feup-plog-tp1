% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(GameState),
    display_game(GameState),
    halt(0).
:-  halt(1).

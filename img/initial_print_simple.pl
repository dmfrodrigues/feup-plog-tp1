% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../board_create.pl'),
    reconsult('../print_simple.pl'),
    initial(GameState),
    display_game_simple(GameState),
    halt(0).
:- halt(1).

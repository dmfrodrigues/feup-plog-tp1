% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../board_create.pl'),
    reconsult('../print_simple.pl'),
    initial(GameState),
    gamestate2json(GameState, JSON),
    json_write(user_output, JSON, [width(10)]),
    halt(0).
:- halt(1).

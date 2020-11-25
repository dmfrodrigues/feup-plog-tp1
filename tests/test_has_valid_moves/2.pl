% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../game_over.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(gamestate(InitialBoard,_InitialTurn)),
    has_valid_moves(InitialBoard, 2),
    halt(0).
:-  halt(1).

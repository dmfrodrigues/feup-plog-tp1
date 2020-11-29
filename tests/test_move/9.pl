% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../src/move.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    reconsult('../../src/print.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard, playermove(2,_,_,_,_),_),
    halt(0).
:-  halt(1).

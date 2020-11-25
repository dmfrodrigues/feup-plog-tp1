% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../valid_moves.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    valid_moves(gamestate(InitialBoard,InitialTurn),InitialTurn,ListOfMoves),
    length(ListOfMoves, L),
    L =:= 1290,
    halt(0).
:-  halt(1).

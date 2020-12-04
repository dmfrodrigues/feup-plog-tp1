% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../src/choose_move.pl'),
    
    InitialTurn = 1,
    InitialBoard = [
        [  0,  6,  0,  0,  0,nan,nan,nan,nan],
        [  0,  0,  0,  0,  0, -6,nan,nan,nan],
        [  0,  0,  0,  0,  0,  0,  0,nan,nan],
        [ -6,  0,  0,  0,  0,  0,  0,  0,nan],
        [  0,  0,  0,  0,  0,  0,  0,  0,  0],
        [nan,  0,  0,  0,  0,  0,  0,  0,  6],
        [nan,nan,  0,  0,  0,  0,  0,  0,  0],
        [nan,nan,nan,  6,  0,  0,  0,  0,  0],
        [nan,nan,nan,nan,  0,  0,  0, -6,  0]
    ],
    statistics(walltime, _),
    choose_move(gamestate(InitialBoard,InitialTurn), InitialTurn, 3, 7, Move),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds),nl,
    move(InitialBoard, Move, _NewBoard),
    halt(0).
:-  halt(1).

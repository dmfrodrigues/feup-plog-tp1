% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../choose_move.pl'),
    current_working_directory(CWD),
    BASE = CWD,
    assert(base_directory(BASE)),

    InitialTurn = 2,
    InitialBoard = [
        [  0, -1,  0,  0,  1,nan,nan,nan,nan],
        [  0,  0,  0,  0,  0,  0,nan,nan,nan],
        [  0,  0,  1,  0,  3,  0,  0,nan,nan],
        [  0,  0, -2,  1, -5,  1,  0,  0,nan],
        [  0,  0,  0, -7,  2,  5,  2,  0,  0],
        [nan,  0,  0, -4,  3, -4, -1,  0,  0],
        [nan,nan,  0,  0, -1,  5,  4,  0,  0],
        [nan,nan,nan,  0,  0,  0,  0,  0,  0],
        [nan,nan,nan,nan,  0,  0,  0,  0,  0]
    ],
    statistics(walltime, _),
    choose_move(gamestate(InitialBoard,InitialTurn), InitialTurn, 5, 10, Move),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds),nl,
    move(InitialBoard, Move, _NewBoard),
    halt(0).
:-  halt(1).

% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../choose_move.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    current_working_directory(CWD),
    BASE = CWD,
    assert(base_directory(BASE)),
    
    initial_state(gamestate(InitialBoard,InitialTurn)),
    statistics(walltime, _),
    choose_move(gamestate(InitialBoard,InitialTurn), 1, 3, 14, Move),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds),nl,
    move(InitialBoard, Move, _NewBoard),
    halt(0).
:-  halt(1).

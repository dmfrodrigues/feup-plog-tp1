% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../value.pl'),
    Player = 1,
    Board = [
        [0,-1,0,0,1,nan,nan,nan,nan],
        [0,0,0,0,2,0,nan,nan,nan],
        [0,0,1,0,3,1,0,nan,nan],
        [0,0,-1,1,-7,1,1,0,nan],
        [0,0,0,-7,2,5,2,0,0],
        [nan,0,0,-5,3,-4,2,0,0],
        [nan,nan,0,0,-1,5,1,0,0],
        [nan,nan,nan,0,0,0,0,0,0],
        [nan,nan,nan,nan,0,0,0,0,0]
    ],
    statistics(walltime, _),
    value(gamestate(Board, Player), Player, Value),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds), nl, write(Value), nl,
    halt(0).
:-  halt(1).

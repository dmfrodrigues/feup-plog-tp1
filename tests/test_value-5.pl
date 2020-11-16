get_value_recursive(_,_,0) :- !.

get_value_recursive(InitialBoard,InitialTurn,N) :-
    value(gamestate(InitialBoard,InitialTurn), 1, _),
    N1 is N-1,
    get_value_recursive(InitialBoard, InitialTurn, N1).

:-
    reconsult('everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    statistics(walltime, _),
    get_value_recursive(InitialBoard,InitialTurn,10000),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds),
    halt(0).
:-  halt(1).

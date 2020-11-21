:-
    reconsult('everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    statistics(walltime, _),
    choose_move(gamestate(InitialBoard,InitialTurn), 1, 2, 5, Move),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds),
    move(InitialBoard, Move, NewBoard),
    GameState = gamestate(NewBoard, 2),
    display_game(GameState),
    halt(0).
:-  halt(1).

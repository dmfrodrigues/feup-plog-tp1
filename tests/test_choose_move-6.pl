:-
    reconsult('everything.pl'),
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
    display_game(gamestate(InitialBoard,InitialTurn)),
    statistics(walltime, _),
    choose_move(gamestate(InitialBoard,InitialTurn), InitialTurn, 3, 5, Move),
    statistics(walltime, [_|[ExecutionTime]]),
    TimeSeconds is ExecutionTime/1000,
    write(TimeSeconds),nl,
    move(InitialBoard, Move, NewBoard),
    GameState = gamestate(NewBoard, 1),
    display_game(GameState),
    halt(0).
:-  halt(1).

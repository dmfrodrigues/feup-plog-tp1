:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    GameState = gamestate(NewBoard, 2),
    has_valid_moves(NewBoard, 2),
    halt(0).
:-  halt(1).

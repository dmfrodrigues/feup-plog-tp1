:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    GameState = gamestate(NewBoard, 2),
    display_game(GameState),
    move(NewBoard, playermove(2, 3-0, [-6], 1, 3-0), NewBoard2),
    halt(0).
:-  halt(1).

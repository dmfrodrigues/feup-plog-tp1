:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,_InitialTurn)),
    move(InitialBoard, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    has_valid_moves(NewBoard, 2),
    halt(0).
:-  halt(1).

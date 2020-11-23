:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,_InitialTurn)),
    has_valid_moves(InitialBoard, 2),
    halt(0).
:-  halt(1).

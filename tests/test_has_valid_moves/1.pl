:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    has_valid_moves(InitialBoard, 1),
    halt(0).
:-  halt(1).

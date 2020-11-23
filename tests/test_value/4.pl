:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,_)),
    move(InitialBoard, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    GameState = gamestate(NewBoard, 2),
    value(GameState, 1, V),
    V =:= 7,
    halt(0).
:-  halt(1).

:-
    reconsult('../game_over.pl'),
    reconsult('../value.pl'),
    reconsult('../sample-states/initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    GameState = gamestate(NewBoard, 2),
    display_game(GameState),
    value(GameState, 1, V),
    display(V),
    halt(0).
:-  halt(1).

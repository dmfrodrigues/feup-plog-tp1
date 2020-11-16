:-
    reconsult('everything.pl'),
    initial_state(GameState),
    display_game(GameState),
    value(GameState, 1, 0),
    value(GameState, 2, 0),
    halt(0).
:-  halt(1).

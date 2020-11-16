:-
    reconsult('everything.pl'),
    intermediate_state(GameState),
    display_game(GameState),
    \+(value(GameState, 1, 999999)),
    halt(0).
:-  halt(1).

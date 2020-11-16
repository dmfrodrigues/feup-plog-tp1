:-
    reconsult('everything.pl'),
    initial_state(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

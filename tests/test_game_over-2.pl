:-
    reconsult('everything.pl'),
    intermediate_state(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

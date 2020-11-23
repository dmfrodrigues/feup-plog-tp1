:-
    reconsult('../everything.pl'),
    intermediate_state(GameState),
    value(GameState, 1, V),
    V =:= 2,
    halt(0).
:-  halt(1).

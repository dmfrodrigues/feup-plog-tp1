:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/intermediate_state.pl'),
    intermediate_state(GameState),
    value(GameState, 1, V),
    V =:= 2,
    halt(0).
:-  halt(1).

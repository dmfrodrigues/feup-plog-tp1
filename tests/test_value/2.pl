:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/intermediate_state.pl'),
    intermediate_state(GameState),
    value(GameState, 1, V),
    V =:= 5.246014300255048,
    halt(0).
:-  halt(1).

:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(GameState),
    value(GameState, 1, 0),
    value(GameState, 2, 0),
    halt(0).
:-  halt(1).

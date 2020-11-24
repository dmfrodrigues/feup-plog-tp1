:-
    reconsult('../../value.pl'),
    reconsult('../../sample-states/final_state.pl'),
    final_state(GameState),
    value(GameState, 1, 999999),
    halt(0).
:-  halt(1).

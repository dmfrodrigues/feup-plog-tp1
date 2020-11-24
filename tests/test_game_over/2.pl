:-
    reconsult('../../game_over.pl'),
    reconsult('../../sample-states/intermediate_state.pl'),
    intermediate_state(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

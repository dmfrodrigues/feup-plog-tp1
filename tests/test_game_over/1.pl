:-
    reconsult('../../game_over.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

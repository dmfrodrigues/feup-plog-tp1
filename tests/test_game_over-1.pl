:-
    reconsult('../game_over.pl'),
    reconsult('../sample-states/initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(GameState),
    display_game(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

:-
    reconsult('../game_over.pl'),
    reconsult('../sample-states/intermediate_state.pl'),
    reconsult('../print.pl'),
    intermediate_state(GameState),
    display_game(GameState),
    \+(game_over(GameState, _)),
    halt(0).
:-  halt(1).

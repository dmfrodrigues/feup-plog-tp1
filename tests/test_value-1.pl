:-
    reconsult('../game_over.pl'),
    reconsult('../value.pl'),
    reconsult('../sample-states/initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(GameState),
    display_game(GameState),
    value(GameState, 1, Value),
    format("Value: ~d ~n", [Value]),
    halt(0).
:-  halt(1).
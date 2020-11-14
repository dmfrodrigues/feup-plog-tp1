:-
    reconsult('initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(GameState),
    display_game(GameState),
    halt(0).
:-  halt(1).

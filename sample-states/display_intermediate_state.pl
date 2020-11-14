:-
    reconsult('intermediate_state.pl'),
    reconsult('../print.pl'),
    intermediate_state(GameState),
    display_game(GameState),
    halt(0).
:-  halt(1).

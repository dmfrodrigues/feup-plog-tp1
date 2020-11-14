:-
    reconsult('final_state.pl'),
    reconsult('../print.pl'),
    final_state(GameState),
    display_game(GameState),
    halt(0).
:-  halt(1).

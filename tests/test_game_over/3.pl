:-
    reconsult('../../game_over.pl'),
    reconsult('../../sample-states/final_state.pl'),
    final_state(GameState),
    game_over(GameState, 1),
    halt(0).
:-  halt(1).

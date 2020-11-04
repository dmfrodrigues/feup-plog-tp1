:-
    reconsult('../board_create.pl'),
    reconsult('../print_simple.pl'),
    initial(GameState),
    display_game_simple(GameState),
    halt(0).
:- halt(1).

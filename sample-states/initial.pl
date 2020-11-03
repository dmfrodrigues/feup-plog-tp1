:-
    reconsult('../board_create.pl'),
    reconsult('../print.pl'),
    initial(GameState),
    display_game(GameState),
    halt(0).
:- halt(1).

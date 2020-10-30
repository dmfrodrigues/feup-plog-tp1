:-
    reconsult('../board_create.pl'),
    reconsult('../print.pl'),
    initial(Board),
    display_game(Board, 1),
    halt(0).
:- halt(1).

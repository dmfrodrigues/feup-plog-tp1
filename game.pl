:- reconsult('board_create.pl'),
   reconsult('print.pl').

/**
 * play()
 * 
 * Entry point of the game
 */
play :-
    assert(turn(1)),
    initial,
    !,
    play_loop.
    
play_loop :-
    start_turn,
    display_game(T1),
    end_turn,
    start_turn,
    display_game(T2),
    end_turn
    .

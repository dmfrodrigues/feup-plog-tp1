:- reconsult('board_create.pl'),
   reconsult('print.pl').

/**
 * play()
 * 
 * Entry point of the game
 */
play :-
    initial(GameState),
    !,
    play_loop(GameState).
    
play_loop(GameState) :-
    display_game(GameState),
    end_turn(GameState, GameState1),
    display_game(GameState1),
    end_turn(GameState1, GameState2)
    .

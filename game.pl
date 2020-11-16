:- consult('board_create.pl'),
   consult('print.pl'),
   consult('user_interface.pl'),
   consult('game_over.pl'),
   consult('moves.pl').

/**
 * play()
 * 
 * Entry point of the game
 */
play :-
    initial_menu.

/**
 * play_game(+Mode)
 * 
 * Starts a match with the given Mode.
 */
play_game(h_h):-
    initial(GameState),
    !,
    play_loop(GameState, h_h).

play_game(c_c):-
    initial(GameState),
    !,
    play_loop(GameState, c_c).

/**
 * play_game(+Mode, Level)
 * 
 * Starts a match with the given Mode and Level.
 */
play_game(h_c, Level):-
    initial(GameState),
    !,
    play_loop(GameState, h_c).

/**
 *
 */
play_loop(gamestate(Board, Turn), h_h) :-
    % Turn 1
    display_game(gamestate(Board, Turn)),
    turn_action(Turn, Board, NewBoard1),
    end_turn(gamestate(NewBoard1, Turn), gamestate(NewBoard1, Turn1)),
    
    \+ game_over(gamestate(NewBoard1, Turn1), 1),

    % Turn 2
    display_game(gamestate(NewBoard1, Turn1)),
    turn_action(Turn1, NewBoard1, NewBoard2),
    end_turn(gamestate(NewBoard2, Turn1), gamestate(NewBoard2, Turn2)),

    \+ game_over(gamestate(NewBoard2, Turn2), 2),

    play_loop(gamestate(NewBoard2, Turn2), h_h).

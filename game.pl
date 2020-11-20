:- consult('board_create.pl'),
   consult('print.pl'),
   consult('user_interface.pl'),
   consult('game_over.pl'),
   consult('moves.pl'),
   consult('choose_move.pl'),
   consult('value.pl').

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
    play_loop(GameState, h_c, Level).

/**
 * Human vs human
 */
play_loop(gamestate(StartBoard, Turn), h_h) :-
    % Turn 1
    display_game(gamestate(StartBoard, Turn)),
    turn_action(Turn, StartBoard, NewBoard1),
    end_turn(gamestate(NewBoard1, Turn), gamestate(NewBoard1, Turn1)),
    display_game(gamestate(NewBoard1, Turn1)),

    (
        (game_over(gamestate(NewBoard1, Turn), 1), display_game_over(Turn));
        (
        % Turn 2
        turn_action(Turn1, NewBoard1, NewBoard2),
        end_turn(gamestate(NewBoard2, Turn1), gamestate(NewBoard2, Turn2)),
            (
            game_over(gamestate(NewBoard2, Turn1), 2);
            play_loop(gamestate(NewBoard2, Turn2), h_h)
            )
        )
    ).


/**
 * Human vs computer
 */
play_loop(gamestate(StartBoard, Turn), h_c, Level) :-
    % Turn 1
    display_game(gamestate(StartBoard, Turn)),
    turn_action(Turn, StartBoard, NewBoard1),
    end_turn(gamestate(NewBoard1, Turn), gamestate(NewBoard1, Turn1)),
    display_game(gamestate(NewBoard1, Turn1)),

    (
        (game_over(gamestate(NewBoard1, Turn), 1), display_game_over(Turn));
        (
        % Turn 2
        choose_move(gamestate(NewBoard1, Turn1), Turn1, 1, Move),
        move(NewBoard1, Move, NewBoard2),
        display_computer_move(Move),
        end_turn(gamestate(NewBoard2, Turn1), gamestate(NewBoard2, Turn2)),
            (
            game_over(gamestate(NewBoard2, Turn1), 2);
            play_loop(gamestate(NewBoard2, Turn2), h_c, Level)
            )
        )
    ).

/**
 * Computer vs computer
 */
play_loop(gamestate(StartBoard, Turn), c_c) :-
    % Turn 1
    display_game(gamestate(StartBoard, Turn)),
    choose_move(gamestate(StartBoard, Turn), Turn, 1, Move1),
    move(StartBoard, Move1, NewBoard1),
    display_computer_move(Move1),
    end_turn(gamestate(NewBoard1, Turn), gamestate(NewBoard1, Turn1)),
    display_game(gamestate(NewBoard1, Turn1)),
    
    (   
        (game_over(gamestate(NewBoard1, Turn), 1), display_game_over(Turn));
        (
        % Turn 2
        choose_move(gamestate(NewBoard1, Turn1), Turn1, 1, Move2),
        move(NewBoard1, Move2, NewBoard2),
        display_computer_move(Move2),
        end_turn(gamestate(NewBoard2, Turn1), gamestate(NewBoard2, Turn2)),
            (
            game_over(gamestate(NewBoard2, Turn1), 2);
            play_loop(gamestate(NewBoard2, Turn2), c_c)
            )
        )   
    ).

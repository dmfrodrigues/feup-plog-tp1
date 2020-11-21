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
    play_loop(GameState, h_h, 1).
play_game(c_c):-
    initial(GameState),
    !,
    play_loop(GameState, c_c, 1).

/**
 * play_game(+Mode, Level)
 * 
 * Starts a match with the given Mode and Level.
 */
play_game(h_c, Level):-
    initial(GameState),
    !,
    play_loop(GameState, h_c, Level, 1).

human_turn_action(gamestate(Board, Turn), NewGameState) :-
    display_game(gamestate(Board, Turn)),
    turn_action(Turn, Board, NewBoard),
    end_turn(gamestate(NewBoard, Turn), NewGameState).
computer_turn_action(gamestate(Board, Turn), NewGameState) :-
    display_game(gamestate(Board, Turn)),
    choose_move(gamestate(Board, Turn), Turn, 1, Move),
    move(Board, Move, NewBoard),
    display_computer_move(Move),
    end_turn(gamestate(NewBoard, Turn), NewGameState).

/**
 * play_loop(+GameState, +Mode, +Round)
 *
 * Play loop with the Mode and GameState.
 */
 % Human vs human
play_loop(gamestate(StartBoard, Turn), h_h, Round) :-
    display_round(Round),
    Round1 is Round+1,
    % Turn 1
    human_turn_action(gamestate(StartBoard, Turn), gamestate(NewBoard1, Turn1)),
    (
        (
            game_over(gamestate(NewBoard1, Turn), 1),
            display_game(gamestate(NewBoard1, Turn1)),
            display_game_over(Turn)
        );
        ( % Turn 2
            human_turn_action(gamestate(NewBoard1, Turn1), gamestate(NewBoard2, Turn2)),
            (
                game_over(gamestate(NewBoard2, Turn1), 2);
                play_loop(gamestate(NewBoard2, Turn2), h_h, Round1)
            )
        )
    ).
% Computer vs computer
play_loop(gamestate(StartBoard, Turn), c_c, Round) :-
    display_round(Round),
    Round1 is Round+1,
    % Turn 1
    computer_turn_action(gamestate(StartBoard, Turn), gamestate(NewBoard1, Turn1)),
    (   
        (
            game_over(gamestate(NewBoard1, Turn), 1),
            display_game(gamestate(NewBoard1, Turn1)),
            display_game_over(Turn)
        );
        ( % Turn 2
            computer_turn_action(gamestate(NewBoard1, Turn1), gamestate(NewBoard2, Turn2)),
            (
                game_over(gamestate(NewBoard2, Turn1), 2);
                play_loop(gamestate(NewBoard2, Turn2), c_c, Round1)
            )
        )   
    ).

/**
 * play_loop(+GameState, +Mode, +Level, +Round)
 *
 * Play loop with the Mode, GameState and with the computer Level.
 */
 % Human vs computer
play_loop(gamestate(StartBoard, Turn), h_c, Level, Round) :-
    display_round(Round),
    Round1 is Round+1,
    % Turn 1
    human_turn_action(gamestate(StartBoard, Turn), gamestate(NewBoard1, Turn1)),
    (
        (
            game_over(gamestate(NewBoard1, Turn), 1),
            display_game(gamestate(NewBoard1, Turn1)),
            display_game_over(Turn)
        );
        ( % Turn 2
            computer_turn_action(gamestate(NewBoard1, Turn1), gamestate(NewBoard2, Turn2)),
            (
                game_over(gamestate(NewBoard2, Turn1), 2);
                play_loop(gamestate(NewBoard2, Turn2), h_c, Level, Round1)
            )
        )
    ).

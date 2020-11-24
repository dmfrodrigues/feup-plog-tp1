:-
    consult('board_create.pl'),
    consult('print.pl'),
    consult('user_interface.pl'),
    consult('game_over.pl'),
    consult('move.pl'),
    consult('choose_move.pl').

:- dynamic
    gamestate_dynamic/1,
    round_dynamic/1.

:-
    current_working_directory(CWD),
    BASE = CWD,
    assert(base_directory(BASE)).

/**
 * play()
 * 
 * Entry point of the game
 */
play :-
    initial_menu.

/**
 * play_game(+Mode, +Level)
 * 
 * Starts a match with the given Mode and Level.
 */
play_game(P1-P2, Level, N):-
    initial(InitialState),
    assertz(round_dynamic(1)),
    assertz(gamestate_dynamic(InitialState)),
    !,
    play_loop(P1-P2, Level, N),
    retract(round_dynamic(_)),
    retract(gamestate_dynamic(_)).

human_turn_action(gamestate(Board, Turn), NewGameState) :-
    display_game(gamestate(Board, Turn)),
    turn_action(Turn, Board, NewBoard),
    end_turn(gamestate(NewBoard, Turn), NewGameState).
computer_turn_action(gamestate(Board, Turn), Level, N, NewGameState) :-
    display_game(gamestate(Board, Turn)),
    statistics(walltime, _),
    choose_move(gamestate(Board, Turn), Turn, Level, N, Move),
    statistics(walltime, [_|[ExecutionTime]]),
    display_time_taken(ExecutionTime),
    move(Board, Move, NewBoard),
    display_computer_move(Move),
    end_turn(gamestate(NewBoard, Turn), NewGameState), !.

is_human(P) :- P = h.

/**
 * play_loop(+Mode, +Level, N)
 *
 * Play loop with the Mode and GameState.
 *
 * Computers will play with difficulty level Level
 */
 % Human vs human
play_loop(P1-P2, Level, N) :-
    repeat,

    round_dynamic(Round),
    gamestate_dynamic(gamestate(StartBoard, Turn)),

    display_round(Round),
    Round1 is Round+1,

    % Turn 1

    (is_human(P1) ->
        human_turn_action(gamestate(StartBoard, Turn), gamestate(NewBoard1, Turn1));
        computer_turn_action(gamestate(StartBoard, Turn), Level, N, gamestate(NewBoard1, Turn1))
    ),
    (
        (
            game_over(gamestate(NewBoard1, Turn), Turn),
            display_game(gamestate(NewBoard1, Turn1)),
            display_game_over(Turn), !
        );
        ( % Turn 2
            (is_human(P2) ->
                human_turn_action(gamestate(NewBoard1, Turn1), gamestate(NewBoard2, Turn2));
                computer_turn_action(gamestate(NewBoard1, Turn1), Level, N, gamestate(NewBoard2, Turn2))
            ),
            (
                (
                    game_over(gamestate(NewBoard2, Turn1), Turn1),
                    display_game(gamestate(NewBoard2, Turn2)),
                    display_game_over(Turn1), !
                );
                (
                    retract(gamestate_dynamic(_)),
                    retract(round_dynamic(_)),
                    assertz(gamestate_dynamic(gamestate(NewBoard2, Turn2))),
                    assertz(round_dynamic(Round1)),
                    fail
                )
            )
        )
    ).

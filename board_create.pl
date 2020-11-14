:- reconsult('board.pl').

:- use_module(library(lists)).
:- reconsult('utils.pl').


/**
 * board_create(-Board)
 * 
 * Create board with width 5. 
 */
board_create(Board) :- board_create(5, Board).

/**
 * board_create(+N, -Board)
 * 
 * Create board with width N.
 */
board_create(N, Board) :-
    board_create(N, 0, Board).

/**
 * board_create(+N, +I, -Board)
 * 
 * Create board with width N; creates lines after and including I. 
 */
board_create(N, I, [          ]) :- I >= 2*N-1.
board_create(N, I, [Line|Board]) :-
    I < 2*N-1,
    board_create_line(N, I, Line),
    I1 is I+1,
    board_create(N, I1, Board).

/**
 * board_create_line(+N, +I, -Line)
 * 
 * Create board line I in a board of width N
 */
board_create_line(N, I, Line) :- board_create_line(N, I, 0, Line).

/**
 * board_create_line(+N, +I, +J, -Line)
 * 
 * Create board line I in a board of width N, starting in column J
 */
board_create_line(N, _, J, []) :- J >= 2*N-1, !.
board_create_line(N, I, J, [nan|Board]) :-
    (
        (J =< I-N);
        (I =< J-N)
    ),
    J1 is J+1,
    board_create_line(N, I, J1, Board),
    !.
board_create_line(N, I, J, [0|Board]) :-
    J1 is J+1,
    board_create_line(N, I, J1, Board),
    !.

/**
 * initial_board(-Board)
 * 
 * Get initial board layout
 */
initial_board(Board) :-
    board_create(Board1),
    board_update(Board1, 0, 1,  6, Board2),
    board_update(Board2, 1, 5, -6, Board3),
    board_update(Board3, 5, 8,  6, Board4),
    board_update(Board4, 8, 7, -6, Board5),
    board_update(Board5, 7, 3,  6, Board6),
    board_update(Board6, 3, 0, -6, Board).

/**
 * initial(-GameState)
 * 
 * Sets up initial game state.
 */
initial(gamestate(Board, 1)) :-
    initial_board(Board).

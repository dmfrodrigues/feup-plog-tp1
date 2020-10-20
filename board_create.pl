:- reconsult('board.pl').

/**
 * board_create()
 * 
 * Create board with width 5. 
 */
board_create :- board_create(5).

/**
 * board_create(+N)
 * 
 * Create board with width N.
 */
board_create(N) :-
    board_create(N, 0).

/**
 * board_create(+N, +I)
 * 
 * Create board with width N; creates lines after and including I. 
 */
board_create(N, I) :- I >= 2*N-1.
board_create(N, I) :-
    board_create_line(N, I),
    I1 is I+1,
    board_create(N, I1).

/**
 * board_create_line(+I, +N)
 * 
 * Create board line I in a board of width N
 */
board_create_line(N, I) :-
    (
        (I   =< N-1, Left is     0, Right is 2*N-1 + (I-N+1));
        (N-1  < I  , Left is I-N+1, Right is 2*N-1          )
    ),
    board_create_line(I, Left, Right).

/**
 * board_create_line(+I, +Left, +Right)
 * 
 * Create line I with J in range [Left, Right).
 */
board_create_line(_, Right, Right) :- !.
board_create_line(I, Left, Right) :-
    assert(board(I, Left, 0)),
    format("~d, ~d, ~d, (~d, ~d)\n", [I, Left, Right, I, Left]),
    Left1 is Left+1,
    board_create_line(I, Left1, Right).

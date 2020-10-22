/**
 * board(+I, +J, -N).
 *
 * Returns number N of pieces in cell (I, J).
 *
 *                      j=0 j=1 j=2 j=3 j=4 j=5 j=6 j=7 j=8
 *                       /   /   /   /   /   /   /   /   /
 *                      /   /   /   /   /   /   /   /   /
 *                                         /   /   /   /
 *                  / \ / \ / \ / \ / \   /   /   /   /
 * i=0 ----------> |   | 6 |   |   |   |     /   /   /
 *                / \ / \ / \ / \ / \ / \   /   /   /
 * i=1 --------> |   |   |   |   |   |-6 |     /   /
 *              / \ / \ / \ / \ / \ / \ / \   /   /
 * i=2 ------> |   |   |   |   |   |   |   |     /
 *            / \ / \ / \ / \ / \ / \ / \ / \   /
 * i=3 ----> |-6 |   |   |   |   |   |   |   |  
 *          / \ / \ / \ / \ / \ / \ / \ / \ / \ 
 * i=4 --> |   |   |   |   |   |   |   |   |   |
 *          \ / \ / \ / \ / \ / \ / \ / \ / \ / 
 * i=5 ----> |   |   |   |   |   |   |   | 6 |
 *            \ / \ / \ / \ / \ / \ / \ / \ /
 * i=6 ------> |   |   |   |   |   |   |   |
 *              \ / \ / \ / \ / \ / \ / \ /
 * i=7 --------> | 6 |   |   |   |   |   |
 *                \ / \ / \ / \ / \ / \ /
 * i=8 ----------> |   |   |   |-6 |   |
 *                  \ / \ / \ / \ / \ /
 * 
 * 
 *
 * | i \ j | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
 * |-------|---|---|---|---|---|---|---|---|---|
 * |     0 |   |   |   |   |   |XXX|XXX|XXX|XXX|
 * |     1 |   |   |   |   |   |   |XXX|XXX|XXX|
 * |     2 |   |   |   |   |   |   |   |XXX|XXX|
 * |     3 |   |   |   |   |   |   |   |   |XXX|
 * |     4 |   |   |   |   |   |   |   |   |   |
 * |     5 |XXX|   |   |   |   |   |   |   |   |
 * |     6 |XXX|XXX|   |   |   |   |   |   |   |
 * |     7 |XXX|XXX|XXX|   |   |   |   |   |   |
 * |     8 |XXX|XXX|XXX|XXX|   |   |   |   |   |
 *
 */
:- dynamic board/3.

/**
 * board_is_valid_position(+I, +J)
 * 
 * Checks if (I, J) is a valid board position
 */
board_is_valid_position(I, J) :-
    (I =< 4, 0   =< J, J =< 4+I);
    (4  < I, I-4 =< J, J =< 8  ).

/**
 * board_update(+I, +J, +N)
 */
board_update(I, J, N) :-
    board_is_valid_position(I, J),
    retract(board(I, J, _)),
    assert(board(I, J, N)).

/**
 * turn(-T)
 * 
 * Returns the player that is playing the current turn:
 * 1 for player 1, 2 for player 2
 */
:- dynamic turn/1.

start_turn :-
    turn(T),
    format("Turn ~d\n", [T]).

end_turn :-
    turn(P),
    format("Player ~d ended turn\n", [P]),
    (P =:= 1 -> P1 is 2 ; P1 is 1),
    retract(turn(_)),
    assert(turn(P1)).

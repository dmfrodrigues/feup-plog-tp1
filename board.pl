:-
    use_module(library(lists)),
    reconsult('utils.pl').

/**
 * gamestate(Board, Turn)
 */

/**
 * board(+Board, +Pos, -N).
 *
 * Returns number N of pieces in cell Pos=(I, J).
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
board(Board, I-J, N) :-
    ground(Board),
    board_is_valid_position(I-J),
    I1 is I+1, nth1(I1, Board, Row),
    J1 is J+1, nth1(J1, Row, N).
    

/**
 * board_is_valid_position(+Pos)
 * 
 * Checks if Pos(I, J) is a valid board position
 */
board_is_valid_position(I-J) :- between(0, 4, I), R is I+4, between(0, R, J).
board_is_valid_position(I-J) :- between(5, 8, I), L is I-4, between(L, 8, J).

/**
 * board_update(+Board, +Pos, +N, -NewBoard)
 * 
 * Updates the value of Board in cell (I,J) to value N,
 * and returns the new board in NewBoard.
 */
board_update(Board, I-J, N, NewBoard) :-
    board_is_valid_position(I-J),
    board_update_recursive(Board, I, J, N, NewBoard).

/**
 * board_update_recursive(+Board, +I, +J, +N, -NewBoard)
 * 
 * Updates the value of Board in cell (I,J) to value N,
 * and returns the new board in NewBoard. Calls recursively,
 * and due to implementation decision the Board that is passed
 * to this predicate may not be consistent.
 */
board_update_recursive([[_|Row]|Board], 0, 0, N, [[N|Row   ]|Board   ]) :- !.                                                                               % Got to the right cell
board_update_recursive([[X|Row]|Board], 0, J, N, [[X|NewRow]|Board   ]) :- J1 is J-1, board_update_recursive([Row|Board], 0, J1, N, [NewRow|Board]), !.     % Got to the right row, searching the right column
board_update_recursive([   Row |Board], I, J, N, [      Row |NewBoard]) :- I1 is I-1, board_update_recursive(Board, I1, J, N, NewBoard), !.                 % Searching the right row

/**
 * next_player(+Player, -NextPlayer)
 * 
 * Get next player.
 */
next_player(Player, NextPlayer) :- NextPlayer is (Player mod 2)+1.

/**
 * end_turn(+GameState, -NewGameState)
 * 
 * Ends current player's turn
 */
end_turn(gamestate(Board, P), gamestate(Board, P1)) :-
    next_player(P, P1).

/**
 * isControlledByPlayer(+Board, +Player, +U)
 * 
 * Finds if cell U is controlled by Player.
 */
isControlledByPlayer(Board, 1, U) :- board(Board, U, N), N > 0.
isControlledByPlayer(Board, 2, U) :- board(Board, U, N), N < 0.

/**
 * isAdj(+U, ?V)
 * 
 * True when U and V are adjacent
 */
isAdj(Ui-Uj, Vi-Vj) :- board_is_valid_position(Ui-Uj), Vi is Ui+1, Vj is Uj  , board_is_valid_position(Vi-Vj).
isAdj(Ui-Uj, Vi-Vj) :- board_is_valid_position(Ui-Uj), Vi is Ui-1, Vj is Uj  , board_is_valid_position(Vi-Vj).
isAdj(Ui-Uj, Vi-Vj) :- board_is_valid_position(Ui-Uj), Vi is Ui  , Vj is Uj+1, board_is_valid_position(Vi-Vj).
isAdj(Ui-Uj, Vi-Vj) :- board_is_valid_position(Ui-Uj), Vi is Ui  , Vj is Uj-1, board_is_valid_position(Vi-Vj).
isAdj(Ui-Uj, Vi-Vj) :- board_is_valid_position(Ui-Uj), Vi is Ui+1, Vj is Uj+1, board_is_valid_position(Vi-Vj).
isAdj(Ui-Uj, Vi-Vj) :- board_is_valid_position(Ui-Uj), Vi is Ui-1, Vj is Uj-1, board_is_valid_position(Vi-Vj).

/**
 * new_piece(+Player, -Piece)
 * 
 * Get new piece placed by player Player.
 */
new_piece(1, 1).
new_piece(2, -1).

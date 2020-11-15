:- use_module(library(lists)).

/**
 * gamestate(Board, Turn)
 */

/**
 * board(+Board, +I, +J, -N).
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
board(Board, I, J, N) :-
    ground(Board),
    board_is_valid_position(Board, I, J),
    I1 is I+1, nth1(I1, Board, Row),
    J1 is J+1, nth1(J1, Row, N).
    

/**
 * board_is_valid_position(+Board, +I, +J)
 * 
 * Checks if (I, J) is a valid board position
 */
board_is_valid_position(_, I, J) :-
    (I =< 4, 0   =< J, J =< 4+I);
    (4  < I, I-4 =< J, J =< 8  ).

/**
 * board_update(+Board, +I, +J, +N, -NewBoard)
 * 
 * Updates the value of Board in cell (I,J) to value N,
 * and returns the new board in NewBoard.
 */
board_update(Board, I, J, N, NewBoard) :-
    board_is_valid_position(Board, I, J),
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
 * end_turn(+GameState, -NewGameState)
 * 
 * Ends current player's turn
 */
end_turn(gamestate(Board, P), gamestate(Board, P1)) :-
    (P =:= 1 -> P1 is 2 ; P1 is 1).

/**
 * isControlledByPlayer(+Board, +Player, +U)
 * 
 * Finds if cell U is controlled by Player.
 */
isControlledByPlayer(Board, 1, Ui-Uj) :- board(Board, Ui, Uj, N), N > 0.
isControlledByPlayer(Board, 2, Ui-Uj) :- board(Board, Ui, Uj, N), N < 0.

/**
 * isAdj(+Board, +U, ?V)
 * 
 * True when U and V are adjacent
 */
isAdj(Board, Ui-Uj, Vi-Vj) :- board_is_valid_position(Board, Ui, Uj), Vi is Ui+1, Vj is Uj  , board_is_valid_position(Board, Vi, Vj).
isAdj(Board, Ui-Uj, Vi-Vj) :- board_is_valid_position(Board, Ui, Uj), Vi is Ui-1, Vj is Uj  , board_is_valid_position(Board, Vi, Vj).
isAdj(Board, Ui-Uj, Vi-Vj) :- board_is_valid_position(Board, Ui, Uj), Vi is Ui  , Vj is Uj+1, board_is_valid_position(Board, Vi, Vj).
isAdj(Board, Ui-Uj, Vi-Vj) :- board_is_valid_position(Board, Ui, Uj), Vi is Ui  , Vj is Uj-1, board_is_valid_position(Board, Vi, Vj).
isAdj(Board, Ui-Uj, Vi-Vj) :- board_is_valid_position(Board, Ui, Uj), Vi is Ui+1, Vj is Uj+1, board_is_valid_position(Board, Vi, Vj).
isAdj(Board, Ui-Uj, Vi-Vj) :- board_is_valid_position(Board, Ui, Uj), Vi is Ui-1, Vj is Uj-1, board_is_valid_position(Board, Vi, Vj).

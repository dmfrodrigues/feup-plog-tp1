:-
    use_module(library(lists)),
    (current_predicate(list_to_set/2) -> true ; use_module(library(sets))).
:-
    reconsult('utils.pl'),
    reconsult('board.pl').

/**
 * no_duplicates(+List)
 * 
 * Asserts if list has no duplicates
 */
no_duplicates(L1) :- sort(L1, L2), list_to_set(L2, L2).

/**
 * canSplitStack(+Stack, +Substacks)
 * 
 * Check if stack can be split into substacks.
 */
canSplitStack(Stack, Substacks) :-
    list_sum(Substacks, Stack),
    no_duplicates(Substacks),
    \+(member(0, Substacks)).

/**
 * move(+Board, ?move(Player, Position, Substacks, Direction))
 * 
 * Determines if a move is valid.
 */
move(Board, playermove(Player, Pos, Substacks, Dir, NewPos), NewBoard) :-
    isControlledByPlayer(Board, Player, Pos),                           % Check if stack is controlled by player
    board(Board, Pos, N), canSplitStack(N, Substacks),                  % Check if substacks are valid
    move_substacks(Board, stacksmove(Pos, Substacks, Dir), NewBoard1),  % Move substacks
    board_update(NewBoard1, Pos, 0, NewBoard2),                         % Delete initial stack
    board(NewBoard2, NewPos, 0),                                        % Check if a new piece can be placed at NewPos
    new_piece(Player, Piece),                                           % Get new piece
    board_update(NewBoard2, NewPos, Piece, NewBoard).                   % Place new piece

/**
 * move_substacks(+Board, +stacksmove(StackPosition, Substacks, Direction), -NewBoard)
 * 
 * Move substacks, and return new board in NewBoard.
 */
move_substacks(Board, stacksmove(  _,            [],   _), Board   ).
move_substacks(Board, stacksmove(Pos, [S|Substacks], Dir), NewBoard) :-
    move_substacks(Board, stacksmove(Pos, Substacks, Dir), NewBoard1),
    move_substack(NewBoard1, stackmove(Pos, S, Dir), NewBoard).

/**
 * move_substack(+Board, +stackmove(StackPosition, StackSize, Direction), -NewBoard)
 * 
 * Move substack with position StackPosition and size StackSize in direction Direction.
 */
move_substack(Board, stackmove(Pos, Size, Dir), NewBoard) :-
    % Check if new position falls outside board
    new_substack_position(stackmove(Pos, Size, Dir), NewPos),
    board_is_valid_position(Board, NewPos),
    % Check if new stack is taller than already-existing stack;
    % if taller or same-size, N+Size is zero or the same sign as Size,
    % thus (N+Size)*Size must be zero or positive.
    board(Board, NewPos, N),
    (N+Size)*Size >= 0,
    % Perform changes
    NewN is (abs(N)+abs(Size))*sign(Size),
    board_update(Board, NewPos, NewN, NewBoard).               

/**
 * new_substack_position(+stackmove(StackPosition, StackSize, Direction), -NewStackPosition)
 * 
 * Get new position of the substack.
 *
 * Direction values:
 * - 1: below left
 * - 2: above right
 * - 3: left
 * - 4: right
 * - 5: above left
 * - 6: below right
 *        j
 *       /
 * i -->
 * 
 *      3     2
 *       \   /
 *        / \
 * 4 <-- | # | --> 1
 *        \ /
 *       /   \
 *      5     6
 */
new_substack_position(stackmove(Ui-Uj, S, 1), Vi-Vj) :- Vi is Ui       , Vj is Uj+abs(S).
new_substack_position(stackmove(Ui-Uj, S, 2), Vi-Vj) :- Vi is Ui-abs(S), Vj is Uj       .
new_substack_position(stackmove(Ui-Uj, S, 3), Vi-Vj) :- Vi is Ui-abs(S), Vj is Uj-abs(S).
new_substack_position(stackmove(Ui-Uj, S, 4), Vi-Vj) :- Vi is Ui       , Vj is Uj-abs(S).
new_substack_position(stackmove(Ui-Uj, S, 5), Vi-Vj) :- Vi is Ui+abs(S), Vj is Uj       .
new_substack_position(stackmove(Ui-Uj, S, 6), Vi-Vj) :- Vi is Ui+abs(S), Vj is Uj+abs(S).

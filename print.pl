/**
 * print_cell(+I, +J)
 * 
 * Prints cell in (I, J) position. 
 */
print_cell(I, J) :-
	board(I, J, V),
	((V >= 0) -> format('| ~d ', [V]); format('|~d ', [V])).

/**
 * print_row(+I, +J; +Length)
 * 
 * Prints row I starting in J with length Length. 
 */
print_row(I, J, Length) :- I < 5 , J > Length - 1.

print_row(_, J, _) :- J > 8.

print_row(I, J, Length) :-
	print_cell(I, J),
	NJ is J + 1,
	print_row(I, NJ, Length).

/**
 * print_void_left(+N)
 * 
 * Prints left void space with size N. 
 */
print_void_left(N) :-
	N1 is (5 - N)*2,
	format('~*c', [N1, 35]).

/**
 * print_void_right(+N)
 * 
 * Prints right void space with size N. 
 */
print_void_right(N) :-
	(integer(N) -> format("|", []) ; true),
	N1 is (5 - N)*2,
	format("~*c ~n", [N1, 35]).

/**
 * print_border_top(+N, +Length)
 * 
 * Prints upper border part, with void space N and size Length. 
 */
print_border_top(N, Length) :-
	N1 is N - 0.5,
	Length1 is Length * 4 - 1,
	print_void_left(N1),
	format('~*s', [Length1, '/ \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\']),
	print_void_right(N1).

/**
 * print_border_bottom(+N, +Length)
 * 
 * Prints lower border part, with void space N and size Length. 
 */
print_border_bottom(N, Length) :-
	N1 is N - 0.5,
	Length1 is Length * 4 - 1,
	print_void_left(N1),
	format('~*s', [Length1, '\\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ /']),
	print_void_right(N1).

/**
 * print_top_rows(+N)
 * 
 * Prints upper rows of the board, starting in row N. 
 */
print_top_rows(4).
print_top_rows(N) :-
	N < 4,
	N1 is N + 1,
	R is N mod 5,
	Length is 5 + N,
	print_border_top(N, Length),
	print_void_left(R),
	print_row(N, 0, Length),
	print_void_right(R),
	print_top_rows(N1).
	
/**
 * print_middle_row()
 * 
 * Prints board middle row. 
 */
print_middle_row :-
	print_border_top(4, 9),
	print_void_left(4),
	print_row(4, 0, 9),
	print_void_right(4),
	print_border_bottom(4, 9).

/**
 * print_bottom_rows(+N)
 * 
 * Prints lower rows of the board, starting in row N. 
 */
print_bottom_rows(9).
print_bottom_rows(N) :-
	N < 9,
	N1 is N + 1,
	R is 8 mod N,
	Length is 5 + R,
	J is 9 - Length,
	print_void_left(R),
	print_row(N, J, Length),
	print_void_right(R),
	print_border_bottom(R, Length),
	print_bottom_rows(N1).

/**
 * display_game(+T)
 * 
 * Display the game from the perspective of player T.
 */
display_game(_) :-
	print_top_rows(0),
	print_middle_row,
	print_bottom_rows(5).

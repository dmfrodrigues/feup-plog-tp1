/**
 * list_sublist(+L, +I, +J, -R)
 * 
 * Gets sublist L[I:J) and returns to R.
 */
list_sublist(   _ , I, I, [   ]) :- !.
list_sublist([X|L], 0, J, [X|R]) :-            J1 is J-1, list_sublist(L,  0, J1, R), !.
list_sublist([_|L], I, J,    R ) :- I1 is I-1, J1 is J-1, list_sublist(L, I1, J1, R).

/**
 * string_substring(+S, +I, +J, -RS)
 * 
 * Gets substring S[I:J) and returns to R.
 */
string_substring(S, I, J, R) :-
	list_sublist(S, I, J, R), !.
string_substring(S, I, J, R) :-
	string_to_list(S, L),
	list_sublist(L, I, J, RL),
	string_to_list(R, RL).

/**
 * print_cell(+I, +J)
 * 
 * Prints cell in (I, J) position. 
 */
print_cell(Board, I, J) :-
	board(Board, I, J, V),
	((V >= 0) -> format('| ~d ', [V]); format('|~d ', [V])).

/**
 * print_row(+Board, +I, +J; +Length)
 * 
 * Prints row I starting in J with length Length. 
 */
print_row(_, I, J, Length) :- I < 5 , J > Length - 1.

print_row(_, _, J, _) :- J > 8.

print_row(Board, I, J, Length) :-
	print_cell(Board, I, J),
	NJ is J + 1,
	print_row(Board, I, NJ, Length).

/**
 * print_void_left(+N)
 * 
 * Prints left void space with size N. 
 */
print_void_left(N) :-
	N1 is round((5 - N)*2),
	format('~*c', [N1, 35]).

/**
 * print_void_right(+N)
 * 
 * Prints right void space with size N. 
 */
print_void_right(N) :-
	(integer(N) -> format("|", []) ; true),
	N1 is round((5 - N)*2),
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
	string_substring("/ \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\", 0, Length1, S),
	format('~s', [S]),
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
	string_substring("\\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ /", 0, Length1, S),
	format('~s', [S]),
	print_void_right(N1).

/**
 * print_top_rows(+Board, +N)
 * 
 * Prints upper rows of the board, starting in row N. 
 */
print_top_rows(_, 4).
print_top_rows(Board, N) :-
	N < 4,
	N1 is N + 1,
	R is N mod 5,
	Length is 5 + N,
	print_border_top(N, Length),
	print_void_left(R),
	print_row(Board, N, 0, Length),
	print_void_right(R),
	print_top_rows(Board, N1).
	
/**
 * print_middle_row(+Board)
 * 
 * Prints board middle row. 
 */
print_middle_row(Board) :-
	print_border_top(4, 9),
	print_void_left(4),
	print_row(Board, 4, 0, 9),
	print_void_right(4),
	print_border_bottom(4, 9).

/**
 * print_bottom_rows(+Board, +N)
 * 
 * Prints lower rows of the board, starting in row N. 
 */
print_bottom_rows(_, 9).
print_bottom_rows(Board, N) :-
	N < 9,
	N1 is N + 1,
	R is 8 mod N,
	Length is 5 + R,
	J is 9 - Length,
	print_void_left(R),
	print_row(Board, N, J, Length),
	print_void_right(R),
	print_border_bottom(R, Length),
	print_bottom_rows(Board, N1).

/**
 * display_game(+Board, +T)
 * 
 * Display the game from the perspective of player T.
 */
display_game(Board, _) :-
	print_top_rows(Board, 0),
	print_middle_row(Board),
	print_bottom_rows(Board, 5).

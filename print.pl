:- reconsult('utils.pl').

:- use_module(library(system)).
isColor :- current_prolog_flag(argv, Arguments), member(color, Arguments).

/**
 * print_cell(+Board, +I, +J)
 * 
 * Prints cell in (I, J) position. 
 */
print_cell(Board, I, J) :-
	board(Board, I, J, V),
	((V =:= 0) ->format('\x2502\   ', []);
		((V > 0) ->
			(isColor -> format('\x2502\\e[41m\e[97m ~d \e[0m', [V]) ; format('\x2502\ ~d ', [V]));
			(isColor -> format('\x2502\\e[43m\e[30m~d \e[0m',  [V]) ; format('\x2502\~d ',  [V]))
		)
	).

/**
 * print_row(+Board, +I, +J, +Length)
 * 
 * Prints row I starting in J with length Length. 
 */
print_row(_, I, J, Length) :- I < 5 , J > Length - 1, !.

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
	N1 is round((5 - N)*2)-2,
	format('~*c', [N1, 32]).

/**
 * print_void_right(+N)
 * 
 * Prints right void space with size N. 
 */
print_void_right(N) :-
	(integer(N) -> format("\x2502\", []) ; true),
	N1 is round((5 - N)*2)+7,
	format("~*c\x2551\~n", [N1, 32]).

/**
 * print_border_top(+N, +Length)
 * 
 * Prints upper border part, with void space N and size Length. 
 */
print_border_top(N, Length) :-
	N1 is N - 0.5,
	Length1 is Length * 4 - 1,
	format("    \x2551\", []),
	print_void_left(N1),
	string_substring("\x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\", 0, Length1, S),
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
	format("    \x2551\", []),
	print_void_left(N1),
	string_substring("\x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\ \x2572\ \x2571\", 0, Length1, S),
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
	format("i=~d \x2551\", [N]),
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
	format("i=~d \x2551\", [4]),
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
	format("i=~d \x2551\", [N]),
	print_void_left(R),
	print_row(Board, N, J, Length),
	print_void_right(R),
	print_border_bottom(R, Length),
	print_bottom_rows(Board, N1).

/**
 * print_player(+P)
 * 
 * Print player that plays next.
 */
print_player(1) :- (isColor -> format('\e[41m\e[97mPlayer 1 turn\e[0m (red/positive):\n',    []) ; format('Player 1 turn (red/positive):\n',    [])).
print_player(2) :- (isColor -> format('\e[43m\e[30mPlayer 2 turn\e[0m (yellow/negative):\n', []) ; format('Player 2 turn (yellow/negative):\n', [])).

/**
 * print_column_indexes
 * 
 * Print column indexes.
 */
print_column_indexes :-
	format("                 j=0 j=1 j=2 j=3 j=4 j=5 j=6 j=7 j=8\n", []),
	format("                  \x2571\   \x2571\   \x2571\   \x2571\   \x2571\   \x2571\   \x2571\   \x2571\   \x2571\ \n", []),
	format("    \x2554\~*c\x2557\\n", [46, 9552]).

/**
 * print_last_row
 * 
 * Print last row.
 */
print_last_row :-
	format("    \x255A\~*c\x255D\\n", [46, 9552]).

/**
 * display_game(+GameState)
 * 
 * Display the game from the perspective of player P.
 */
display_game(gamestate(Board, P)) :-
	print_player(P),
	print_column_indexes,
	print_top_rows(Board, 0),
	print_middle_row(Board),
	print_bottom_rows(Board, 5),
	print_last_row.

/*
*	This file contains print predicates
*
*/
%board(i, j , n)

board_side(5).

board(0, 0 , 1).
board(0, 1 , 2).
board(0, 2 , 3).
board(0, 3 , 4).
board(0, 4 , 5).

board(1, 0 , 1).
board(1, 1 , 2).
board(1, 2 , 3).
board(1, 3 , 4).
board(1, 4 , 5).
board(1, 5 , 6).

board(2, 0 , 1).
board(2, 1 , 2).
board(2, 2 , 3).
board(2, 3 , 4).
board(2, 4 , 5).
board(2, 5 , 6).
board(2, 6 , 7).

board(3, 0 , 1).
board(3, 1 , 2).
board(3, 2 , 3).
board(3, 3 , 4).
board(3, 4 , 5).
board(3, 5 , 6).
board(3, 6 , 7).
board(3, 7 , 8).

board(4, 0 , 1).
board(4, 1 , 2).
board(4, 2 , 3).
board(4, 3 , 4).
board(4, 4 , 5).
board(4, 5 , 6).
board(4, 6 , 7).
board(4, 7 , 8).
board(4, 8 , 9).

board(5, 0 , 1).
board(5, 1 , 2).
board(5, 2 , 3).
board(5, 3 , 4).
board(5, 4 , 5).
board(5, 5 , 6).
board(5, 6 , 7).
board(5, 7 , 8).
board(5, 8 , 9).
board(5, 9 , 10).

board(10, 0 , 5).
board(10, 1 , 4).
board(10, 2 , 3).
board(10, 3 , 2).
board(10, 4 , 1).

board(9, 0 , 6).
board(9, 1 , 5).
board(9, 2 , 4).
board(9, 3 , 3).
board(9, 4 , 2).
board(9, 5 , 1).

board(8, 0 , 7).
board(8, 1 , 6).
board(8, 2 , 5).
board(8, 3 , 4).
board(8, 4 , 3).
board(8, 5 , 2).
board(8, 6 , 1).

board(7, 0 , 8).
board(7, 1 , 7).
board(7, 2 , 6).
board(7, 3 , 5).
board(7, 4 , 4).
board(7, 5 , 3).
board(7, 6 , 2).
board(7, 7 , 1).

board(6, 0 , 9).
board(6, 1 , 8).
board(6, 2 , 7).
board(6, 3 , 6).
board(6, 4 , 5).
board(6, 5 , 4).
board(6, 6 , 3).
board(6, 7 , 2).
board(6, 8 , 1).

printCell(I, J) :-
	board(I, J, V),
	format(' ~d ', [V]).

printRow(_, J) :- J < 0.

printRow(I, J) :-
	J >= 0,
	printCell(I, J),
	NJ is J - 1,
	printRow(I, NJ).

printVoidLeft(N) :-
	N1 is 5 - N,
	format('~*c', [N1, 35]).
	
printVoidRight(N) :-
	N1 is 5 - N,
	format('~*c ~n', [N1, 35]).

printTopBoard(N) :-
	N < 4,
	N1 is N + 1,
	R is N mod 5,
	Length is 4 + N,
	printVoidLeft(R),
	printRow(N, Length),
	printVoidRight(R),
	printTopBoard(N1).

printMiddleBoard :-
	printRow(4, 8).

printBottomBoard(N) :-
	N < 9,
	N1 is N + 1,
	R is 9 mod N,
	Length is 4 + R,
	printVoidLeft(R),
	printRow(N, Length),
	printVoidRight(R),
	printBottomBoard(N1).

printBoard :-
	printTopBoard(0);
	printMiddleBoard;
	printBottomBoard(5).

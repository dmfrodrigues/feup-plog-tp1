printCell(I, J) :-
	board(I, J, V),
	format(' ~d ', [V]).

printRow(I, J, Length) :- I < 5 , J > Length - 1.

printRow(_, J, _) :- J > 8.

printRow(I, J, Length) :-
	printCell(I, J),
	NJ is J + 1,
	printRow(I, NJ, Length).

printVoidLeft(N) :-
	N1 is 5 - N,
	format('~*c', [N1, 35]).
	
printVoidRight(N) :-
	N1 is 5 - N,
	format('~*c ~n', [N1, 35]).

printTopBoard(4).
printTopBoard(N) :-
	N < 4,
	N1 is N + 1,
	R is N mod 5,
	Length is 5 + N,
	printVoidLeft(R),
	printRow(N, 0, Length),
	printVoidRight(R),
	printTopBoard(N1).

printMiddleBoard :-
	printVoidLeft(4),
	printRow(4, 0, 8),
	printVoidRight(4).

printBottomBoard(9).
printBottomBoard(N) :-
	N < 9,
	N1 is N + 1,
	R is 8 mod N,
	Length is 5 + R,
	J is 9 - Length,
	printVoidLeft(R),
	printRow(N, J, Length),
	printVoidRight(R),
	printBottomBoard(N1).

printBoard :-
	printTopBoard(0),
	printMiddleBoard,
	printBottomBoard(5).

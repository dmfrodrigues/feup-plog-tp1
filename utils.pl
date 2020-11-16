:-
	use_module(library(lists)).

/**
 * list_create(+X, +N, -List)
 * 
 * Create list with size N and filled with X,
 * and return it in List.
 */
list_create(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).

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
 * SICStus and SWI compatible.
 */
string_substring(S, I, J, R) :-
	list_sublist(S, I, J, R), !.
string_substring(S, I, J, R) :-
	string_to_list(S, L),
	list_sublist(L, I, J, RL),
	string_to_list(R, RL).

/**
 * between(+L, +R, ?I)
 * 
 * If I is binded, it checks if L =< I =< R.
 * If I is not binded, it is successively assigned
 * to the integers between L and R inclusive.
 */
between(L, R, I) :- ground(I), !, L =< I, I =< R.
between(L, L, I) :- I is L, !.
between(L, R, I) :- L < R, I is L.
between(L, R, I) :- L < R, L1 is L+1, between(L1, R, I).

/**
 * list_sum(?List, ?R)
 * 
 * R is the result of the list.
 * If List is grounded, R is returned;
 * If R is grounded, lists are successively returned, with different elements
 */
list_sum(L, R) :- ground(L), sumlist(L, R).
list_sum(L, R) :- list_sum_(R, 0, L).

/**
 * list_sum_(+R, +N, -L)
 * 
 * Returns list L adding up R, where all elements of L are greater than N.
 */
list_sum_(0, _, []) :- !.
list_sum_(R, N, [X|L]) :-
	R > 0, !,
	N1 is N+1,
	between(N1, R, X),
	R1 is R-X,
	list_sum_(R1, X, L).
list_sum_(R, 0, L) :-
	R1 is abs(R),
	list_sum_(R1, 0, L1),
	maplist(negation, L1, L).

/**
 * negation(+X, -Y)
 * 
 * Negates X and returns in Y;
 * X+Y = 0
 */
negation(X, Y) :- Y is -X.

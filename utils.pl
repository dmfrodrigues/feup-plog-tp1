% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
	use_module(library(lists)),
	use_module(library(system)).

:-
	reconsult('maplist_multi.pl').

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

/**
 * intersects(+L1, +L2)
 * 
 * Check if two lists have any elements in common.
 */
intersects([H|_],List) :-
    member(H,List),
    !.
intersects([_|T],List) :-
    intersects(T,List).

/**
 * display_list(L)
 * 
 * Display contents of list L, one element per line.
 */
display_list([]).
display_list([X|L]) :-
	write(X),nl,
	display_list(L).

/**
 * take(L, N, R)
 * 
 * Takes at most the first N elements of L, and returns them to R.
 */
take(_,0,[]).
take([],_,[]).
take([X|L], N, [X|R]) :-
	N1 is N-1,
	take(L, N1, R).

pairs_values(Pairs, Values) :- pairs_keys_values(Pairs, _, Values).
pairs_keys_values([], [], []).
pairs_keys_values([K-V|Pairs], [K|Keys], [V|Values]) :- pairs_keys_values(Pairs, Keys, Values).

maplist(_, [], [], [], []).
maplist(Predicate, [X1|L1], [X2|L2], [X3|L3], [X4|L4]) :-
	T =.. [Predicate, X1, X2, X3, X4],
	T,
	maplist(Predicate, L1, L2, L3, L4).

current_working_directory(CWD) :-
	current_prolog_flag(dialect, sicstus),
	environ('SP_STARTUP_DIR', CWD).

current_working_directory(CWD) :-
	current_prolog_flag(dialect, swi),
	working_directory(CWD, CWD).

:- dynamic base_directory/1.

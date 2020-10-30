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

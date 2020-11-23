maplist_multi(_, [], [], []).
maplist_multi(Predicate, [X1|L1], [X2|L2], [X3|L3]) :-
	T =.. [Predicate, X1, X2, X3],
	T,
	maplist_multi(Predicate, L1, L2, L3).

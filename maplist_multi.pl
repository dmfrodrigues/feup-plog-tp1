:-
   reconsult('prolog-multiprocessing/multiprocessing.pl'). 

maplist_multi(Includes, Predicate, L1, L2, L3) :-
    maplist_multi_(Includes, 10, Predicate, L1, L2, L3).

maplist_multi_(       _,        0,         _, [], [], []) :- !.
maplist_multi_(Includes, Nthreads, Predicate, L1, L2, L3) :-
    length(L1, S),
    Si is div(S, Nthreads),
    length(L1left, Si), append(L1left, L1right, L1),
    length(L2left, Si), append(L2left, L2right, L2),
    length(L3left, Si), append(L3left, L3right, L3),
    multiprocessing_create(
        (
            use_module(library(lists)),
            Includes,
            maplist(Predicate, L1left, L2left, Ret),
            write(Ret),
            format(".~n", [])
        ),
        Out
    ),
    NthreadsRight is Nthreads-1,
    maplist_multi_(Includes, NthreadsRight, Predicate, L1right, L2right, L3right),
    read(Out, L3left).

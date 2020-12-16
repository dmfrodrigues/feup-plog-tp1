% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:- use_module(library(system)).
is_parallel :- current_prolog_flag(argv, Arguments), member(parallel, Arguments).

:-  is_parallel -> 
        reconsult('../prolog-multiprocessing/multiprocessing.pl');
        true.  

:-
    ((current_predicate(base_directory/1), base_directory(_)) -> true ; 
        (
            current_working_directory(CWD),
            BASE = CWD,
            assert(base_directory(BASE))
        )
    ).

% maplist_multi/5
maplist_multi(_, 1, Predicate, L1, L2, L3) :- 
    !,
    maplist(Predicate, L1, L2, L3).
maplist_multi(Includes, Nthreads, Predicate, L1, L2, L3) :-
    is_parallel,
    length(L1, S),
    (mod(S, Nthreads) =:= 0 -> Si is div(S, Nthreads) ; Si is div(S, Nthreads)+1),
    length(L1left, Si), append(L1left, L1right, L1),
    length(L2left, Si), append(L2left, L2right, L2),
    length(L3left, Si), append(L3left, L3right, L3),
    
    base_directory(BASE),
    atom_concat(BASE, 'obj/lists.po', LISTS),
    multiprocessing_create(
        (
            (
                (current_prolog_flag(dialect, sicstus), load_files([LISTS]));
                (current_prolog_flag(dialect, swi    ), use_module(library(lists)))
            ),
            Includes,
            maplist(Predicate, L1left, L2left, Ret),
            write(Ret),
            format('.~n', [])
        ),
        Out
    ),
    NthreadsRight is Nthreads-1,
    maplist_multi(Includes, NthreadsRight, Predicate, L1right, L2right, L3right),
    read(Out, L3left),
    close(Out).
maplist_multi(_, _, Predicate, L1, L2, L3) :-
    \+(is_parallel),
    maplist(Predicate, L1, L2, L3).

% maplist_multi/6
maplist_multi(_, 1, Predicate, L1, L2, L3, L4) :-
    !,
    maplist(Predicate, L1, L2, L3, L4).
maplist_multi(Includes, Nthreads, Predicate, L1, L2, L3, L4) :-
    is_parallel,
    length(L1, S),
    Si is div(S, Nthreads),
    length(L1left, Si), append(L1left, L1right, L1),
    length(L2left, Si), append(L2left, L2right, L2),
    length(L3left, Si), append(L3left, L3right, L3),
    length(L4left, Si), append(L4left, L4right, L4),
    multiprocessing_create(
        (
            use_module(library(lists)),
            Includes,
            maplist(Predicate, L1left, L2left, L3left, Ret),
            write(Ret),
            format(".~n", [])
        ),
        Out
    ),
    NthreadsRight is Nthreads-1,
    maplist_multi(Includes, NthreadsRight, Predicate, L1right, L2right, L3right, L4right),
    read(Out, L4left),
    close(Out).
maplist_multi(_, _, Predicate, L1, L2, L3, L4) :-
    \+(is_parallel),
    maplist(Predicate, L1, L2, L3, L4).

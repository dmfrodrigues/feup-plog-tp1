:-
    use_module(library(system)).

wait_busy(N) :-
    statistics(walltime, [StartTimer|_]),
    repeat,
        statistics(walltime, [EndTimer|_]),
        EndTimer-StartTimer >= N,
    !.

print_me(L, L, hey) :-
    wait_busy(1000).

:-
    reconsult('../everything.pl'),
    List = [h,e,l,l,o],
    list_create(List, 10, Lists),
    statistics(walltime, [StartTime|_]),
    maplist_multi(print_me, Lists, Lists, NewLists),
    statistics(walltime, [EndTime|_]),
    Interval is EndTime-StartTime,
    write(Interval),nl,
    write(NewLists),nl,
    halt(0).
:-  halt(1).

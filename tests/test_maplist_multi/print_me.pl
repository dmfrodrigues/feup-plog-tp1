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

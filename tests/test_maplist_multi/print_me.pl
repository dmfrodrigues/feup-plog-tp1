:-
    use_module(library(system)).

wait_busy(N) :-
    statistics(walltime, [StartTimer|_]),
    repeat,
        statistics(walltime, [EndTimer|_]),
        EndTimer-StartTimer >= N,
    !.

print_me(N, N, M) :- M is 2*N,
    wait_busy(1000).

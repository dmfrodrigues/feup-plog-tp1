% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

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

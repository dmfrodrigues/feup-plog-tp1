% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../maplist_multi.pl'),
    reconsult('../../utils.pl'),
    reconsult('print_me.pl'),

    current_working_directory(CWD),
    BASE_PATH = CWD,
    assert(base_directory(BASE_PATH)),
    
    findall(X, between(0,6,X), L),
    statistics(walltime, [StartTime|_]),
    atom_concat(BASE_PATH, 'tests/test_maplist_multi/print_me.pl', PRINT_ME),
    maplist_multi(
        (
            reconsult(PRINT_ME)
        ),
        7,
        print_me,
        L,
        L,
        NewL
    ),
    statistics(walltime, [EndTime|_]),
    Interval is EndTime-StartTime,
    write(Interval),nl,
    write(NewL),nl,
    halt(0).
:-  halt(1).

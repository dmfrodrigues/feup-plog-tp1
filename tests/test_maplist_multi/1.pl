:-
    reconsult('../everything.pl'),
    reconsult('print_me.pl'),

    current_working_directory(CWD),
    BASE_PATH = CWD,
    assert(base_directory(BASE_PATH)),
    
    findall(X, between(0,9,X), L),
    statistics(walltime, [StartTime|_]),
    atom_concat(BASE_PATH, 'tests/test_maplist_multi/print_me.pl', PRINT_ME),
    maplist_multi(
        (
            reconsult(PRINT_ME)
        ),
        8,
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

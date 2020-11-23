:-
    reconsult('../everything.pl'),
    reconsult('print_me.pl'),
    List = [h,e,l,l,o],
    list_create(List, 10, Lists),
    statistics(walltime, [StartTime|_]),
    current_working_directory(CWD),
    atom_concat(CWD, 'tests/test_maplist_multi/print_me.pl', PRINT_ME),
    maplist_multi(
        (
            reconsult(PRINT_ME)
        ),
        print_me,
        Lists,
        Lists,
        NewLists
    ),
    statistics(walltime, [EndTime|_]),
    Interval is EndTime-StartTime,
    write(Interval),nl,
    write(NewLists),nl,
    halt(0).
:-  halt(1).

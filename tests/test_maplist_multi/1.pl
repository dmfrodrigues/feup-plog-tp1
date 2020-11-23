:-
    reconsult('../everything.pl'),
    reconsult('print_me.pl'),
    List = [h,e,l,l,o],
    list_create(List, 10, Lists),
    statistics(walltime, [StartTime|_]),
    maplist_multi(
        (
            reconsult('print_me.pl')
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

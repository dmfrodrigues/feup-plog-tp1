:-
    reconsult('../moves.pl'),
    reconsult('../sample-states/initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(gamestate(Board1,_)),
    display_game(gamestate(Board1,1)),
    move(Board1,playermove(1,0-1,[1,2,3],6,0-0),Board2),
    display_game(gamestate(Board2,2)),
    move(Board2,playermove(2,1-5,[-1,-2,-3],4,0-1),Board3),
    display_game(gamestate(Board3,1)),
    move(Board3,playermove(1,0-0,[1],1,0-0),Board4),
    display_game(gamestate(Board4,1)),
    halt(0).
:-  halt(1).

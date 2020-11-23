:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    \+(move(InitialBoard,playermove(2,3-0,[-1,-2,-3],1,3-1),_)),
    halt(0).
:-  halt(1).

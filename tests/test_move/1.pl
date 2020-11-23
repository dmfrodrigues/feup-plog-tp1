:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard,playermove(1,0-1,[1,2,3],5,0-0),NewBoard),
    display_game(gamestate(NewBoard,InitialTurn)),
    halt(0).
:-  halt(1).

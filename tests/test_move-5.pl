:-
    reconsult('../moves.pl'),
    reconsult('../sample-states/initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard,playermove(2,3-0,[-1,-2,-3],1,3-0),NewBoard),
    display_game(gamestate(NewBoard,InitialTurn)),
    halt(0).
:-  halt(1).
:-
    reconsult('../../move.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    reconsult('../../print.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    move(InitialBoard, playermove(2,_,_,_,_),_),
    halt(0).
:-  halt(1).

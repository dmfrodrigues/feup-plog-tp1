:-
    reconsult('everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    valid_moves(gamestate(InitialBoard,InitialTurn),InitialTurn,ListOfMoves),
    display(ListOfMoves),
    halt(0).
:-  halt(1).

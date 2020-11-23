:-
    reconsult('../everything.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    valid_moves(gamestate(InitialBoard,InitialTurn),InitialTurn,ListOfMoves),
    length(ListOfMoves, 1290),
    halt(0).
:-  halt(1).

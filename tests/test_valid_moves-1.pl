:-
    reconsult('../valid_moves.pl'),
    reconsult('../sample-states/initial_state.pl'),
    reconsult('../print.pl'),
    initial_state(gamestate(InitialBoard,InitialTurn)),
    display_game(gamestate(InitialBoard,InitialTurn)),
    % spy(valid_moves/3),
    valid_moves(gamestate(InitialBoard,InitialTurn),InitialTurn,ListOfMoves),
    display(ListOfMoves),
    halt(0).
:-  halt(1).

% reconsult('moves.pl'),reconsult('sample-states/initial_state.pl'),reconsult('print.pl'),initial_state(gamestate(InitialBoard,InitialTurn)),display_game(gamestate(InitialBoard,InitialTurn)),move(InitialBoard, Move, _).
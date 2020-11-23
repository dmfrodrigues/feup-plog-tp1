:-
    reconsult('../everything.pl'),
    initial_state(gamestate(Board,Turn)),
    move(Board, playermove(Turn, 7-3, [6], 2, 8-8), NewBoard),
    next_player(Turn, NewTurn),
    NewGameState = gamestate(NewBoard, NewTurn),
    display_game(NewGameState),
    move(NewBoard, playermove(NewTurn, 3-0, [-6], 1, 3-0), NewBoard2),
    next_player(NewTurn, NewTurn2),
    NewGameState2 = gamestate(NewBoard2, NewTurn2),
    display_game(NewGameState2),
    halt(0).
:-  halt(1).

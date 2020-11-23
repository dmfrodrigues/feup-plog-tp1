:-
    reconsult('../everything.pl'),
    initial_state(gamestate(Board,Turn)),
    move(Board, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    next_player(Turn, NewTurn),
    NewGameState = gamestate(NewBoard, NewTurn),
    \+(game_over(NewGameState, _)),
    halt(0).
:-  halt(1).

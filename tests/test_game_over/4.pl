% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../../src/game_over.pl'),
    reconsult('../../sample-states/initial_state.pl'),
    initial_state(gamestate(Board,Turn)),
    move(Board, playermove(1, 7-3, [6], 2, 8-8), NewBoard),
    next_player(Turn, NewTurn),
    NewGameState = gamestate(NewBoard, NewTurn),
    \+(game_over(NewGameState, _)),
    halt(0).
:-  halt(1).

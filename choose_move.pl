:-
    reconsult('choose_move_1.pl').


/**
 * choose_move(+GameState, +Player, +Level, -Move)
 * 
 * Choose best move, using a certain level of difficulty
 */
choose_move(gamestate(Board, Turn), Turn, Level, N, Move) :-
    choose_move_1(gamestate(Board, Turn), Turn, Level, N, Move).

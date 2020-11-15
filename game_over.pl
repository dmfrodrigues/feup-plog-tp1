:-
    use_module(library(lists)).
:-
    reconsult('board.pl').

/**
 * leadsTo(+Board, +Player, +U, +V, -Path)
 * 
 * True when U leads to V.
 */
leadsTo(Board, Player, Path, U, U, [U|Path]) :- isControlledByPlayer(Board, Player, U).
leadsTo(Board, Player, Path, U, D,    Sol  ) :- isControlledByPlayer(Board, Player, U),
    isAdj(Board, U, V),
    isControlledByPlayer(Board, Player, V),
    \+(member(V, Path)),
    leadsTo(Board, Player, [U|Path], V, D, Sol).

/**
 * game_over(+GameState, -Winner)​
 * 
 * Evaluates if game is over, and returns winner if it is over
 */
game_over(gamestate(Board, Turn), 1) :- game_over_(gamestate(Board, Turn), 1).
game_over(gamestate(Board, Turn), 2) :- game_over_(gamestate(Board, Turn), 2).
game_over_(gamestate(Board, Turn), Winner) :-
    game_over_top(gamestate(Board, Turn), Winner);
    game_over_left(gamestate(Board, Turn), Winner);
    game_over_diagonal(gamestate(Board, Turn), Winner).

game_over_top(gamestate(Board, _), Winner) :- 
    ground(Board),
    (
        leadsTo(Board, Winner, [], 0-0, 8-4, _);
        leadsTo(Board, Winner, [], 0-0, 8-5, _);
        leadsTo(Board, Winner, [], 0-0, 8-6, _);
        leadsTo(Board, Winner, [], 0-0, 8-7, _);
        leadsTo(Board, Winner, [], 0-0, 8-8, _);
        leadsTo(Board, Winner, [], 0-1, 8-4, _);
        leadsTo(Board, Winner, [], 0-1, 8-5, _);
        leadsTo(Board, Winner, [], 0-1, 8-6, _);
        leadsTo(Board, Winner, [], 0-1, 8-7, _);
        leadsTo(Board, Winner, [], 0-1, 8-8, _);
        leadsTo(Board, Winner, [], 0-2, 8-4, _);
        leadsTo(Board, Winner, [], 0-2, 8-5, _);
        leadsTo(Board, Winner, [], 0-2, 8-6, _);
        leadsTo(Board, Winner, [], 0-2, 8-7, _);
        leadsTo(Board, Winner, [], 0-2, 8-8, _);
        leadsTo(Board, Winner, [], 0-3, 8-4, _);
        leadsTo(Board, Winner, [], 0-3, 8-5, _);
        leadsTo(Board, Winner, [], 0-3, 8-6, _);
        leadsTo(Board, Winner, [], 0-3, 8-7, _);
        leadsTo(Board, Winner, [], 0-3, 8-8, _);
        leadsTo(Board, Winner, [], 0-4, 8-4, _);
        leadsTo(Board, Winner, [], 0-4, 8-5, _);
        leadsTo(Board, Winner, [], 0-4, 8-6, _);
        leadsTo(Board, Winner, [], 0-4, 8-7, _);
        leadsTo(Board, Winner, [], 0-4, 8-8, _)
    ).

game_over_left(gamestate(Board, _), Winner) :- 
    ground(Board),
    (
        leadsTo(Board, Winner, [], 0-0, 4-8, _);
        leadsTo(Board, Winner, [], 0-0, 5-8, _);
        leadsTo(Board, Winner, [], 0-0, 6-8, _);
        leadsTo(Board, Winner, [], 0-0, 7-8, _);
        leadsTo(Board, Winner, [], 0-0, 8-8, _);
        leadsTo(Board, Winner, [], 1-0, 4-8, _);
        leadsTo(Board, Winner, [], 1-0, 5-8, _);
        leadsTo(Board, Winner, [], 1-0, 6-8, _);
        leadsTo(Board, Winner, [], 1-0, 7-8, _);
        leadsTo(Board, Winner, [], 1-0, 8-8, _);
        leadsTo(Board, Winner, [], 2-0, 4-8, _);
        leadsTo(Board, Winner, [], 2-0, 5-8, _);
        leadsTo(Board, Winner, [], 2-0, 6-8, _);
        leadsTo(Board, Winner, [], 2-0, 7-8, _);
        leadsTo(Board, Winner, [], 2-0, 8-8, _);
        leadsTo(Board, Winner, [], 3-0, 4-8, _);
        leadsTo(Board, Winner, [], 3-0, 5-8, _);
        leadsTo(Board, Winner, [], 3-0, 6-8, _);
        leadsTo(Board, Winner, [], 3-0, 7-8, _);
        leadsTo(Board, Winner, [], 3-0, 8-8, _);
        leadsTo(Board, Winner, [], 4-0, 4-8, _);
        leadsTo(Board, Winner, [], 4-0, 5-8, _);
        leadsTo(Board, Winner, [], 4-0, 6-8, _);
        leadsTo(Board, Winner, [], 4-0, 7-8, _);
        leadsTo(Board, Winner, [], 4-0, 8-8, _)
    ).

game_over_diagonal(gamestate(Board, _), Winner) :- 
    ground(Board),
    (
        leadsTo(Board, Winner, [], 4-0, 0-4, _);
        leadsTo(Board, Winner, [], 4-0, 1-5, _);
        leadsTo(Board, Winner, [], 4-0, 2-6, _);
        leadsTo(Board, Winner, [], 4-0, 3-7, _);
        leadsTo(Board, Winner, [], 4-0, 4-8, _);
        leadsTo(Board, Winner, [], 5-1, 0-4, _);
        leadsTo(Board, Winner, [], 5-1, 1-5, _);
        leadsTo(Board, Winner, [], 5-1, 2-6, _);
        leadsTo(Board, Winner, [], 5-1, 3-7, _);
        leadsTo(Board, Winner, [], 5-1, 4-8, _);
        leadsTo(Board, Winner, [], 6-2, 0-4, _);
        leadsTo(Board, Winner, [], 6-2, 1-5, _);
        leadsTo(Board, Winner, [], 6-2, 2-6, _);
        leadsTo(Board, Winner, [], 6-2, 3-7, _);
        leadsTo(Board, Winner, [], 6-2, 4-8, _);
        leadsTo(Board, Winner, [], 7-3, 0-4, _);
        leadsTo(Board, Winner, [], 7-3, 1-5, _);
        leadsTo(Board, Winner, [], 7-3, 2-6, _);
        leadsTo(Board, Winner, [], 7-3, 3-7, _);
        leadsTo(Board, Winner, [], 7-3, 4-8, _);
        leadsTo(Board, Winner, [], 8-4, 0-4, _);
        leadsTo(Board, Winner, [], 8-4, 1-5, _);
        leadsTo(Board, Winner, [], 8-4, 2-6, _);
        leadsTo(Board, Winner, [], 8-4, 3-7, _);
        leadsTo(Board, Winner, [], 8-4, 4-8, _)
    ).

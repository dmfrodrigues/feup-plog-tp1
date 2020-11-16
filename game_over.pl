:-
    use_module(library(lists)).
:-
    reconsult('board.pl'),
    reconsult('moves.pl'). 

/**
 * leadsTo(+Board, +Player, +U, +V, -Path)
 * 
 * True when U leads to V.
 */
leadsTo(Board, Player, Path, U, U, [U|Path]) :- isControlledByPlayer(Board, Player, U).
leadsTo(Board, Player, Path, U, D,    Sol  ) :- isControlledByPlayer(Board, Player, U),
    isAdj(U, V),
    isControlledByPlayer(Board, Player, V),
    \+(member(V, Path)),
    leadsTo(Board, Player, [U|Path], V, D, Sol).

/**
 * has_valid_moves(+Board, +Player)
 * 
 * Asserts if player has valid moves in the provided Board.
 */
has_valid_moves(Board, Player) :-
    !,
    move(Board, playermove(Player,_,_,_,_),_).

/**
 * game_over(+GameState, -Winner)​
 * 
 * Evaluates if game is over, and returns winner if it is over
 */
game_over(gamestate(Board, Turn), 1) :- game_over_(gamestate(Board, Turn), 1).
game_over(gamestate(Board, Turn), 2) :- game_over_(gamestate(Board, Turn), 2).
game_over_(gamestate(Board, _), Winner) :- next_player(Winner, P), \+(has_valid_moves(Board, P)).
game_over_(gamestate(Board, Turn), Winner) :-
    game_over_top(gamestate(Board, Turn), Winner);
    game_over_left(gamestate(Board, Turn), Winner);
    game_over_diagonal(gamestate(Board, Turn), Winner).

game_over_top(gamestate(Board, _), Winner) :- 
    ground(Board),
    member(U, [0-0,0-1,0-2,0-3,0-4]),
    member(V, [8-4,8-5,8-6,8-7,8-8]),
    leadsTo(Board, Winner, [], U, V, _).

game_over_left(gamestate(Board, _), Winner) :- 
    ground(Board),
    member(U, [0-0,1-0,2-0,3-0,4-0]),
    member(V, [4-8,5-8,6-8,7-8,8-8]),
    leadsTo(Board, Winner, [], U, V, _).

game_over_diagonal(gamestate(Board, _), Winner) :- 
    ground(Board),
    member(U, [4-0,5-1,6-2,7-3,8-4]),
    member(V, [0-4,1-5,2-6,3-7,4-8]),
    leadsTo(Board, Winner, [], U, V, _).

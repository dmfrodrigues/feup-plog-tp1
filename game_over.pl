:-
    use_module(library(lists)).
:-
    reconsult('board.pl'),
    reconsult('moves.pl'). 

/**
 * dfs(+Board, +Player, +Stack, +Visited, -Ret)
 * 
 * Finds nodes reachable from Stack.
 */
dfs(Board, Player, [U|Stack], Visited, Dest   ) :- % Ignore if already in Visited
    member(U, Visited), !,
    dfs(Board, Player, Stack, Visited, Dest   ).
dfs(Board, Player, [U|Stack], Visited, Dest   ) :- % If U is under control, add adjacent
    isControlledByPlayer(Board, Player, U),
    (
        member(U, Dest);
        (
            findall(
                V, 
                (
                    isAdj(U, V),
                    isControlledByPlayer(Board, Player, V)
                ),
                AddToStack
            ),
            append(AddToStack, Stack, NewStack),
            dfs(Board, Player, NewStack, [U|Visited], Dest)
        )
    ).
dfs(Board, Player, [_|Stack], Visited, Dest   ) :- % U is not under control, ignore
    dfs(Board, Player, Stack, Visited, Dest   ).

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
    dfs(Board, Winner, [0-0,0-1,0-2,0-3,0-4], [], [8-4,8-5,8-6,8-7,8-8]).

game_over_left(gamestate(Board, _), Winner) :- 
    ground(Board),
    dfs(Board, Winner, [0-0,1-0,2-0,3-0,4-0], [], [4-8,5-8,6-8,7-8,8-8]).

game_over_diagonal(gamestate(Board, _), Winner) :-
    ground(Board),
    dfs(Board, Winner, [4-0,5-1,6-2,7-3,8-4], [], [0-4,1-5,2-6,3-7,4-8]).

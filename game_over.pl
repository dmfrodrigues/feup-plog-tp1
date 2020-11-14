:-
    use_module(library(lists)).

/**
 * game_over(+GameState, -Winner)​
 * 
 * Evaluates if game is over, and returns winner if it is over
 */
game_over(Gamestate, Winner) :-
    game_over_left(GameState, Winner);
    game_over_top(GameState, Winner);
    game_over_diag(GameState, Winner).

game_over_left(gamestate(Board, Turn), 1) :-
    dfs(Board, 1, 0-0, Visited0),
    dfs(Board, 1, 1-0, Visited1),
    dfs(Board, 1, 2-0, Visited2),
    dfs(Board, 1, 3-0, Visited3),
    dfs(Board, 1, 4-0, Visited4),
    append(Visited0   , Visited1, Visited01   ),
    append(Visited01  , Visited2, Visited012  ),
    append(Visited012 , Visited3, Visited0123 ),
    append(Visited0123, Visited4, Visited01234),
    remove_duplicates(Visited01234, Visited),
    (
        member(4-8, Visited);
        member(5-8, Visited);
        member(6-8, Visited);
        member(7-8, Visited);
        member(8-8, Visited)
    )
    .

:-
    reconsult('sample-states/final_state.pl'),
    reconsult('print.pl'),
    final_state(GameState),
    display_game(GameState),
    game_over(GameState, Winner),
    format("Winner is ~d~n", [Winner]).

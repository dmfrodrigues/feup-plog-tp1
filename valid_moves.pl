:-
    reconsult('moves.pl').

/**
 * valid_moves(+GameState, +Player, -ListOfMoves)
 * 
 * Get list of valid moves.
 */
valid_moves(gamestate(Board, Player), Player, ListOfMoves) :- 
    setof(Move, move(Board, Move, _), ListOfMoves).

:-
    reconsult('moves.pl').

/**
 * valid_moves(+GameState, +Player, -ListOfMoves)
 * 
 * Get list of valid moves.
 */
valid_moves(gamestate(Board, Player), Player, ListOfMoves) :- 
    findall(Move, move(Board, Move, _), ListOfMoves).

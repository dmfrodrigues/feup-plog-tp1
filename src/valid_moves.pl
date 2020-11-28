% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('move.pl').

/**
 * valid_moves(+GameState, +Player, -ListOfMoves)
 * 
 * Get list of valid moves.
 */
valid_moves(gamestate(Board, Player), Player, ListOfMoves) :- 
    findall(
        playermove(Player, Pos, Substacks, Dir, NewPos),
        move(Board, playermove(Player, Pos, Substacks, Dir, NewPos), _),
        ListOfMoves
    ).

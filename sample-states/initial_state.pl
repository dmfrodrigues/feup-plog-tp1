% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    reconsult('../board_create.pl').

/**
 * initial_state(-GameState)
 * 
 * Get initial state.
 */
initial_state(GameState) :-
    initial(GameState).

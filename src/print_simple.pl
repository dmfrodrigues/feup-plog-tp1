% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
	use_module(library(json)).

gamestate2json(gamestate(Board, Turn), JSON) :-
	JSON = json(
		[
			'board'=Board,
			'turn'=Turn
		]
	).

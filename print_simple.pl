:- reconsult('utils.pl').

display_game_simple(gamestate(Board, P)) :-
	format("~d~n", [P]),
	display_board_simple(Board, 0, 0).

display_board_simple(_, 9, _) :- !.
display_board_simple(_, _, 9) :- !.
display_board_simple(Board, I, 0) :-
	!,
	display_cell_simple(Board, I, 0),
	display_board_simple(Board, I, 1),
	I1 is I+1,
	display_board_simple(Board, I1, 0).
display_board_simple(Board, I, J) :-
	!,
	display_cell_simple(Board, I, J),
	J1 is J+1,
	display_board_simple(Board, I, J1).

display_cell_simple(Board, I, J) :-
	!,
	(board_is_valid_position(I-J)) -> (
		board(Board, I-J, N),
		(N =\= 0 -> format("~d ~d ~d~n", [I, J, N]) ; true)
	); (
		true
	).

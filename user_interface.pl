display_menu :-
    nl,
    format("GLAISHER~n~n", []),
    format("1. Play~n", []),
    format("2. Instructions~n", []),
    format("0. Quit~n~n", []).

display_play_options :-
    nl,
    format("1. Human vs Human~n", []),
    format("2. Human vs Computer~n", []),
    format("3. Computer vs Computer~n", []),
    format("0. Back~n~n", []).

display_instructions :-
    nl,
    format("Players take turns in doing two consecutive, mandatory actions:~n~n", []),
    format("1) Separate and move a stack: a stack can be separated into many substacks (it can also be 'separated' into a single substack), under the condition that all substacks must have different heights.", []), 
    format("After separating the stack, all substacks must move in the same direction, and each stack travels as many hexes as it is tall (e.g., a 2-substack must travel 2 hexes), including over adversary stacks.~n~n", []),
    format("2) Place a new piece: grab a new piece from the reserve, and place it in any empty hex with your color facing up (thus creating a 1-stack).~n~n", []),
    format("The objective is to connect any pair of opposite sides of the board with a contiguous chain of stacks with your color. A player can also lose when he has no legal moves in item 1.~n~n", []),
    format("Press any key to back~n~n", []).

initial_menu :-
    repeat,
    display_menu,
    format("Option: ", []), read(Option),
    exec_initial_menu(Option), !.

exec_initial_menu(0):-
    halt(0).

exec_initial_menu(1):-
    repeat,
    display_play_options,
    format("Option: ", []), read(Option),
    exec_initial_menu(Option), !.

exec_initial_menu(2):-
    display_instructions,
    read(Option),
    initial_menu.

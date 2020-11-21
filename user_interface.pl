/*
 * display_menu
 *
 * Displays the initial menu.
*/
display_menu :-
    nl,
    format(" \x259F\\x2580\\x2580\\x2580\\x2599\ \x2588\ \x2597\\x2584\\x2584\\x2596\\x2584\ \x2580\ \x2597\\x2584\\x2584\\x2584\ \x2588\    \x2597\\x2584\\x2584\\x2596\ \x2584\\x2597\\x2584\ ~n", []),
    format(" \x2588\ \x2584\\x2584\\x2584\ \x2588\ \x2588\  \x259C\\x2588\ \x2588\ \x259C\\x2584\\x2584\\x2596\ \x2588\\x2580\\x2580\\x2599\ \x2588\\x2584\\x2584\\x2588\ \x2588\\x2580\  ~n", []),
    format(" \x259C\\x2584\\x2584\\x2584\\x259B\ \x2588\ \x259C\\x2584\\x2584\\x259B\\x2588\ \x2588\ \x2584\\x2584\\x2584\\x259B\ \x2588\  \x2588\ \x259C\\x2584\\x2584\\x2596\ \x2588\   ~n", []),
    nl,
    format(" A game for two players by Ken Shoda~n", []),
    format(" Developed by Breno Pimentel & Diogo Rodrigues, in SICStus/SWI Prolog~n", []),
    nl,
    format(" (C) 2020 Diogo Rodrigues, Breno Pimentel (developers)~n", []),
    format(" Based the homonymous game by Nestor Romeral Andres and Ken Shoda, publicly available through nestorgames~n", []),
    format(" We lay claim only over the software; this software cannot be used for commercial purposes~n", []),
    format(" Made available under GNU General Public License v3, copyrighted material used under fair use for education~n", []),
    nl,
    format("1. Play~n", []),
    format("2. Instructions~n", []),
    format("0. Quit~n~n", []).

/*
 * display_play_options
 *
 * Displays play modes.
*/
display_play_options :-
    nl,
    format("1. Human vs Human~n", []),
    format("2. Human vs Computer~n", []),
    format("3. Computer vs Computer~n", []),
    format("0. Back~n~n", []).

/*
 * display_choose_level
 *
 * Displays computer A.I. levels.
*/
display_choose_level :-
    nl,
    format("1. Level 1~n", []),
    format("2. Level 2~n", []),
    format("0. Back~n~n", []).

/*
 * display_instructions
 *
 * Displays game instructions.
*/
display_instructions :-
    nl,
    format("Players take turns in doing two consecutive, mandatory actions:~n~n", []),
    format("1) Separate and move a stack: a stack can be separated into many substacks (it can also be 'separated' into a single substack), under the condition that all substacks must have different heights.", []), 
    format("After separating the stack, all substacks must move in the same direction, and each stack travels as many hexes as it is tall (e.g., a 2-substack must travel 2 hexes), including over adversary stacks.~n~n", []),
    format("2) Place a new piece: grab a new piece from the reserve, and place it in any empty hex with your color facing up (thus creating a 1-stack).~n~n", []),
    format("The objective is to connect any pair of opposite sides of the board with a contiguous chain of stacks with your color. A player can also lose when he has no legal moves in item 1.~n~n", []),
    format("# How to move~n~n", []),
    format("- Position: provide a pair of indexes representing the position of the stack you want to split, separated by an hypen (e.g., 0-1)~n", []),
    format("- Substacks: provide a list of integers, of the same sign and adding up to the number in the position you selected before (e.g., [4, 2])~n", []),
    format("- Direction: provide a number from 1 to 6, indicating the direction you want to move your substacks (e.g., 1)~n", []),
    format("- New Position: provide a pair of indexes representing the cell where you will place your new 1-stack (e.g., 0-0)~n~n", []),
    format("Directions:~n", []),
    format("      3     2      ~n", []),
    format("       \x2572\   \x2571\       ~n", []),
    format("        \x2571\ \x2572\        ~n", []),
    format(" 4 <\x2500\\x2500\ \x2502\ # \x2502\ \x2500\\x2500\> 1 ~n", []),
    format("        \x2572\ \x2571\        ~n", []),
    format("       \x2571\   \x2572\       ~n", []),
    format("      5     6      ~n", []),
    format("~n", []),
    format("Enter any key to go back~n~n", []).

/*
 * initial_menu
 *
 * Starts initial menu and wait for input.
*/
initial_menu :-
    repeat,
    display_menu,
    format("Option: ", []), read_input(Option),
    exec_initial_menu(Option), !.

/*
 * exec_initial_menu(+Option)
 *
 * Executes initial menu Option.
*/
exec_initial_menu(0):-
    abort.
exec_initial_menu(1):-
    repeat,
    display_play_options,
    format("Option: ", []), read_input(Option),
    exec_play_options(Option), !.
exec_initial_menu(2):-
    display_instructions,
    read_input(_),
    initial_menu.

/*
 * exec_play_options(+Option)
 *
 * Executes play modes menu Option.
*/
exec_play_options(0) :-
    initial_menu.
% human vs human
exec_play_options(1) :-
    play_game(h_h).
% human vs computer
exec_play_options(2) :-
    repeat,
    display_choose_level,
    format("Option: ", []), read_input(Option),
    exec_choose_level(Option), !.
% computer vs computer
exec_play_options(3) :-
    play_game(c_c).

/*
 * exec_choose_level(+Option)
 *
 * Executes choose levels menu Option.
*/
exec_choose_level(0) :-
    initial_menu.
% level 1
exec_choose_level(1) :-
    play_game(h_c, 1).
% level 2
exec_choose_level(2) :-
    play_game(h_c, 2).

/*
 * turn_action(+Player, +Board, -NewBoard)
 *
 * Reads the Player movement in the Board and returns the NewBoard.
 * It repeats until a valid move is done.
*/
turn_action(Player, Board, NewBoard):-
    display_game(gamestate(Board, Player)),
    repeat,
    format("Movement   (q. to exit game)~n", []),
    format("Position: ", []), read_input(Pos), exit_game(Pos),
    format("Substacks: ", []), read_input(Substacks), exit_game(Substacks),
    format("Direction: ", []), read_input(Dir), exit_game(Dir),
    format("New Position: ", []), read_input(NewPos), exit_game(NewPos),
    move(Board, playermove(Player, Pos, Substacks, Dir, NewPos), NewBoard),
    !.

/*
 * display_computer_move(+Move)
 *
 * Displays the computer Move.
*/
display_computer_move(playermove(_, Pos, Substacks, Dir, NewPos)):-
    write('Computer movement'), nl,
    write('Position: '), write(Pos), nl,
    write('Substacks: '), write(Substacks), nl,
    write('Direction: '), write(Dir), nl,
    write('New Position: '), write(NewPos), nl, nl.

/*
 * display_game_over(+Winner)
 *
 * Displays the Winner after a game over.
*/
display_game_over(Winner) :-
    format("~nGame Over~n", []),
    format("Player ~d is the winner~n", [Winner]),
    format("Enter any key to go back~n~n", []),
    read_input(_),
    initial_menu.

/*
 * exit_game(+Input)
 *
 * Returns to initial menu if Input is equal to q, otherwise evaluates to true.
*/
exit_game(Input) :-
    ((Input = q) ->
    initial_menu; true).

/*
 * read_input(+Input)
 * 
 * Read the next Prolog term from the current input stream.
 * If a not valid term is provided, it tries again until it receives one that is.
*/
read_input(Input):-
    repeat,
    catch(read(Input), _Error, false),
    !.

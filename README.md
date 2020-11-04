# Glaisher

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

![Test](https://github.com/dmfrodrigues/feup-plog-tp1/workflows/Test/badge.svg)

- **Project name:** Glaisher
- **Short description:** Board game implemented in PROLOG
- **Environment:** SICStus PROLOG
- **Tools:** PROLOG
- **Institution:** [FEUP](https://sigarra.up.pt/feup/en/web_page.Inicial)
- **Course:** [PLOG](https://sigarra.up.pt/feup/en/UCURR_GERAL.FICHA_UC_VIEW?pv_ocorrencia_id=459482) (Logic Programming) <!-- - **Project grade:** ??.?/20.0 -->
- **TP class:** 3MIEIC02
- **Group:** Glaisher_4
- **Group members:** 
    - [Breno Accioly de Barros Pimentel](https://github.com/BrenoAccioly) (<up201800170@fe.up.pt>)
    - [Diogo Miguel Ferreira Rodrigues](https://github.com/dmfrodrigues) (<up201806429@fe.up.pt>)

## The game

The game we implemented is called [Glaisher](https://nestorgames.com/#glaisher_detail) (the rules are available [here](https://nestorgames.com/rulebooks/GLAISHER_EN.pdf)), named after [Glaisher's theorem](https://en.wikipedia.org/wiki/Glaisher%27s_theorem).
It is played on a hexagonal board ([hex map](https://en.wikipedia.org/wiki/Hex_map)) with a side of 5 hexagonal cells (hexes). Each player has a color, usually red for Player 1 and yellow for Player 2.
There are 75 double-sided pieces painted red on one side and yellow on the other.

### Preparation

Each player places three 6-stacks (stacks of 6 pieces) of his/her color (all pieces with his/her color facing up) on the board as per the following image.
The rest of the pieces are kept in a shared reserve.

<img src="img/initial.jpg" width="300">

### Game play

Players take turns in doing two consecutive, mandatory actions:
1. **Separate and move a stack:** a stack can be separated into many substacks (it can also be "separated" into a single substack), under the condition that all substacks must have different heights. After separating the stack, all substacks must move in the same direction, and each stack travels as many hexes as it is tall (e.g., a 2-substack must travel 2 hexes), including over adversary stacks.
    - If a substack moves to a hex with a taller opponent stack, the move is illegal.
    - If a substack moves to a hex with a shorter or equal opponent stack, your stack captures the opponent stack.
2. **Place a new piece:** grab a new piece from the reserve, and place it in any empty hex with your color facing up (thus creating a 1-stack).

The objective is to connect any pair of opposite sides of the board with a contiguous chain of stacks with your color. A player can also lose when he has no legal moves in item 1.

## Internal game state representation

The game is internally represented as a list of lists that can be queried using predicate `board(Board, I, J, N)`, meaning in position `(I, J)` there is a stack of `N` pieces, with `N` positive if the stack is made of red pieces, and negative if it is made of yellow pieces.

```txt
                     j=0 j=1 j=2 j=3 j=4 j=5 j=6 j=7 j=8
                      /   /   /   /   /   /   /   /   /
                     /   /   /   /   /   /   /   /   /
                                        /   /   /   /
                 / \ / \ / \ / \ / \   /   /   /   /
i=0 ----------> |   | 6 |   |   |   |     /   /   /
               / \ / \ / \ / \ / \ / \   /   /   /
i=1 --------> |   |   |   |   |   |-6 |     /   /
             / \ / \ / \ / \ / \ / \ / \   /   /
i=2 ------> |   |   |   |   |   |   |   |     /
           / \ / \ / \ / \ / \ / \ / \ / \   /
i=3 ----> |-6 |   |   |   |   |   |   |   |  
         / \ / \ / \ / \ / \ / \ / \ / \ / \ 
i=4 --> |   |   |   |   |   |   |   |   |   |
         \ / \ / \ / \ / \ / \ / \ / \ / \ / 
i=5 ----> |   |   |   |   |   |   |   | 6 |
           \ / \ / \ / \ / \ / \ / \ / \ /
i=6 ------> |   |   |   |   |   |   |   |
             \ / \ / \ / \ / \ / \ / \ /
i=7 --------> | 6 |   |   |   |   |   |
               \ / \ / \ / \ / \ / \ /
i=8 ----------> |   |   |   |-6 |   |
                 \ / \ / \ / \ / \ /
```

The cells adjacent to `(I, J)` are:
- `(I+1, J)` (above right)
- `(I-1, J)` (below left)
- `(I, J-1)` (left)
- `(I, J+1)` (right)
- `(I-1, J-1)` (above left)
- `(I+1, J+1)` (below right)

Some positions are not valid (e.g. `(1, 6)`), which can be checked by calling `board_is_valid_position(I, J)`.

The turn (current player) is saved using dynamic predicate `turn(T)`, which returns `T=1` when it is Player 1's turn, and `T=2` when it is player 2's turn.
A player can end his/her turn by calling `end_turn`.

Although the physical board game comes with 75 pieces, the game play is not limited in any way by the lack of pieces since it is assumed there is always the required number of pieces.
Thus, we will not keep the number of pieces in reserve.

## Game state visualization

To run the program using colored text, run sicstus/swi with argument `-a color`.

Under **Linux**, `sh` and `bash` should correctly present special characters; if they are coloured, they should also correctly present colors.

Under **Windows**, when using any console you are advised to use one of the following fonts, which have been confirmed to correctly render all characters:
- Consolas
- DejaVu Sans Mono (preferred)
- Source Code Pro

Under **Windows**, colors are correctly displayed in all situations, except on the SICStus console (where colors do not render but the rest is fine), and `sicstus` running on cmd/PowerShell (colors are rendered as unknown characters).

### Initial state

<img src="img/in_game_initial_board.png" width="300">

### Intermediate state

<img src="img/in_game_intermediate_board.png" width="300">

### Final state

<img src="img/in_game_final_board.png" width="300">

## Inner workings

Once initialized with `initial(-Board)`, the game board can be visualized with `display_game(+Board, +T)`, which uses predicates `print_top_rows(+Board, +N)`, `print_middle_row(+Board, +N)` and `print_bottom_rows(+Board, +N)`.
These use `print_row(+Board, +I, +J, +Length)`, to print a specific row *I*, and `print_cell(+Board, +I, +J)`, to print a specific cell *(I, J)*, alongside helper predicates to format the border, such as `print_void_left(+N)`, `print_void_right(+N)`, `print_border_top(+N, +Length)` and `print_border_bottom(+N, +Length)`.

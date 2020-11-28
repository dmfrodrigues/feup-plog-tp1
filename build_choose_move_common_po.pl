% (C) 2020 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3

:-
    compile(['src/choose_move_common.pl']),
    save_predicates(
        [
            get_move_value_pair/3,
            move/3,
            value/3,
            isControlledByPlayer/3,
            board/3,
            board_is_valid_position/1,
            between/3,
            canSplitStack/2,
            list_sum/2,
            no_duplicates/1,
            move_substacks/3,
            move_substack/3,
            new_substack_position/2,
            board_update/4,
            board_update_recursive/5,
            new_piece/2,
            game_over/2,
            game_over_/2,
            next_player/2,
            has_valid_moves/2,
            list_sum_/3,
            negation/2,
            game_over_top/2,
            game_over_left/2,
            game_over_diagonal/2,
            dfs/4,
            dfs_/5,
            isAdj/2,
            value_line/4,
            position_value/2,
            adjacent_to_another_stack/3
        ],
        'obj/choose_move_common'
    ),
    halt.
:-  halt(1).

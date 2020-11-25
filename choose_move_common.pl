:-
    reconsult('utils.pl'),
    reconsult('value.pl').

/**
 * get_move_value_pair(+gamestate(Board, Player), +Move, -(V-Move))
 * 
 * Gets value of board after performing Move, and returns a value-move pair.
 *
 * To be used in best_N_moves. If it is player 1, V is the symmetric of the actual value,
 * because it is to be sorted in descending order, but keysort sorts in ascending order.
 */
get_move_value_pair(gamestate(Board, Player), Move, V-Move) :- 
    Move = playermove(P, PI-PJ, Substacks, Dir,  NewPosI-NewPosJ),
    move(Board, Move, NewBoard),
    value(gamestate(NewBoard, Player), Player, V1),
    length(Substacks, SubLen),
    V2 is V1 + (P + PI + PJ + Dir + SubLen + NewPosI + NewPosJ)/10000000,
    (Player =:= 1 -> V is -V2 ; V is V2).

/**
 * best_N_moves(+gamestate(Board, Turn), +Level, +ListOfMoves, +N, -ListOfBestMoves)
 * 
 * Get the best N moves from ListOfMoves
 */
best_N_moves(gamestate(Board, Turn), ListOfMoves, N, ListOfBestMoves) :-
    length(ListOfMoves, L),
    list_create(gamestate(Board,Turn), L, GameStates),
    (L >= 512 -> 
        (
            base_directory(BASE),
            % atom_concat(BASE, 'choose_move_common.pl', CHOOSE_MOVE_COMMON),
            atom_concat(BASE, 'obj/choose_move_common.po', CHOOSE_MOVE_COMMON),
            maplist_multi(
                (
                    % reconsult(CHOOSE_MOVE_COMMON),
                    load_files([CHOOSE_MOVE_COMMON]),
                    assert(base_directory(BASE))
                ),
                8,
                get_move_value_pair,
                GameStates,
                ListOfMoves,
                ListOfMovesPairs
            )
        );
        (
            maplist(
                get_move_value_pair,
                GameStates,
                ListOfMoves,
                ListOfMovesPairs
            )
        )
    ),
    keysort(ListOfMovesPairs, SortedListOfMovesPairs),
    take(SortedListOfMovesPairs, N, ListOfBestMovesPairs),
    pairs_values(ListOfBestMovesPairs, ListOfBestMoves).

/**
 * best_move(+GameState, +ListOfMoves, -BestMove, -BestValue)
 * 
 * Choose best move from list.
 */
best_move(gamestate(Board, Turn), ListOfMoves, Move, V) :-
    length(ListOfMoves, L),
    list_create(gamestate(Board,Turn), L, GameStates),
    maplist(
        get_move_value_pair,
        GameStates,
        ListOfMoves,
        ListOfMovesPairs
    ),
    min_member(V1-Move, ListOfMovesPairs),
    (Turn =:= 1 -> V is -V1 ; V is V1).

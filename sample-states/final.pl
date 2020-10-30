:-
    reconsult('../board_create.pl'),
    reconsult('../print.pl'),
    board_create(Board00),
    board_update(Board00, 0,0,-1, Board01), board_update(Board01, 0,2,-1, Board02), board_update(Board02, 0,4, 1, Board03),
    board_update(Board03, 1,2,-1, Board04),
    board_update(Board04, 2,3,-6, Board05), board_update(Board05, 2,5, 3, Board06), board_update(Board06, 2,6, 1, Board07),
    board_update(Board07, 3,2, 2, Board08), board_update(Board08, 3,3, 3, Board09), board_update(Board09, 3,4, 5, Board10), board_update(Board10, 3,5, 1, Board11),
    board_update(Board11, 4,0, 1, Board12), board_update(Board12, 4,1, 2, Board13), board_update(Board13, 4,2, 1, Board14), board_update(Board14, 4,4,-3, Board15),
    board_update(Board15, 5,2,-3, Board16), board_update(Board16, 5,3,-1, Board17), board_update(Board17, 5,4,-3, Board18),
    board_update(Board18, 6,3,-1, Board19), board_update(Board19, 6,5, 2, Board20),
    board_update(Board20, 7,3,-1, Board21), board_update(Board21, 7,7, 1, Board22),
    display_game(Board22, 1).

:-
    reconsult('../board_create.pl'),
    board_create,
    board_update(0,0,-1), board_update(0,2,-1), board_update(0,4,1),
    board_update(1,2,-1),
    board_update(2,3,-6), board_update(2,5, 3), board_update(2,6, 1),
    board_update(3,2, 2), board_update(3,3, 3), board_update(3,4, 5), board_update(3,5, 1),	
    board_update(4,0, 1), board_update(4,1, 2), board_update(4,2, 1), board_update(4,4,-3),
    board_update(5,2,-3), board_update(5,3,-1), board_update(5,4,-3),
    board_update(6,3,-1), board_update(6,5, 2),
    board_update(7,3,-1), board_update(7,7, 1).

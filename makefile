# To test with SICStus PROLOG, run make test PROLOG=sicstus
PROLOG=swipl
CLASS=T2
GROUP=Glaisher4
ZIPNAME=PLOG_TP1_RI_$(CLASS)_$(GROUP)

all:

zip: $(ZIPNAME).zip

$(ZIPNAME).zip:
	rm -rf $(ZIPNAME)
	mkdir -p $(ZIPNAME)
	cp -r img sample-states board_create.pl board.pl game.pl print.pl utils.pl README.md LICENSE $(ZIPNAME)
	cd $(ZIPNAME) && zip ../$@ -r .
	rm -rf $(ZIPNAME)

test: test_samples test_game_over test_move test_has_valid_moves test_value test_valid_moves test_choose_move

test_samples:
	$(PROLOG) --noinfo -q -l sample-states/display_initial_state.pl
	$(PROLOG) --noinfo -q -l sample-states/display_intermediate_state.pl
	$(PROLOG) --noinfo -q -l sample-states/display_final_state.pl

	$(PROLOG) --noinfo -q -l sample-states/display_initial_state.pl      -- color
	$(PROLOG) --noinfo -q -l sample-states/display_intermediate_state.pl -- color
	$(PROLOG) --noinfo -q -l sample-states/display_final_state.pl        -- color
	
test_game_over:
	$(PROLOG) --noinfo -q -l tests/test_game_over-1.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_game_over-2.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_game_over-3.pl -- color

test_move:
	$(PROLOG) --noinfo -q -l tests/test_move-1.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-2.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-3.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-4.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-5.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-6.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-7.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-8.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_move-9.pl -- color

test_has_valid_moves:
	$(PROLOG) --noinfo -q -l tests/test_has_valid_moves-1.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_has_valid_moves-2.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_has_valid_moves-3.pl -- color

test_valid_moves:
	$(PROLOG) --noinfo -q -l tests/test_valid_moves-1.pl -- color

test_value:
	$(PROLOG) --noinfo -q -l tests/test_value-1.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_value-2.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_value-3.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_value-4.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_value-5.pl -- color

test_choose_move:
	$(PROLOG) --noinfo -q -l tests/test_choose_move-1.pl -- color 
	$(PROLOG) --noinfo -q -l tests/test_choose_move-2.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_choose_move-3.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_choose_move-4.pl -- color
	$(PROLOG) --noinfo -q -l tests/test_choose_move-5.pl -- color

svg: img/initial_print_simple.svg img/intermediate_print_simple.svg img/final_print_simple.svg

img/%_print_simple.svg: img/%_print_simple.txt
	cd $(@D) && cat $(<F) | python3 printsimple2svg.py > $(@F)

img/%_print_simple.txt: img/%_print_simple.pl
	cd $(@D) && $(PROLOG) -q -l $(<F) > $(@F)

clean:
	rm *.zip

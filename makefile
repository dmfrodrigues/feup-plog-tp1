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

test: test_samples

test_samples:
	$(PROLOG) -q -l sample-states/display_initial_state.pl
	$(PROLOG) -q -l sample-states/display_intermediate_state.pl
	$(PROLOG) -q -l sample-states/display_final_state.pl

	$(PROLOG) -q -l sample-states/display_initial_state.pl      -a color
	$(PROLOG) -q -l sample-states/display_intermediate_state.pl -a color
	$(PROLOG) -q -l sample-states/display_final_state.pl        -a color
	

svg: img/initial_print_simple.svg img/intermediate_print_simple.svg img/final_print_simple.svg

img/%_print_simple.svg: img/%_print_simple.txt
	cd $(@D) && cat $(<F) | python3 printsimple2svg.py > $(@F)

img/%_print_simple.txt: img/%_print_simple.pl
	cd $(@D) && $(PROLOG) -q -l $(<F) > $(@F)

clean:
	rm *.zip

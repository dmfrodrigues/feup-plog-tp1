# To test with SICStus PROLOG, run make test PROLOG=sicstus
PROLOG=swipl
CLASS=T2
GROUP=Glaisher4

all:

zip: PLOG_TP1_RI_$(CLASS)_$(GROUP).zip

PLOG_TP1_RI_$(CLASS)_$(GROUP).zip:
	rm -rf PLOG_TP1_RI_$(CLASS)_$(GROUP)
	mkdir -p PLOG_TP1_RI_$(CLASS)_$(GROUP)
	cp -r img sample-states board_create.pl board.pl game.pl print.pl utils.pl README.md LICENSE PLOG_TP1_RI_$(CLASS)_$(GROUP)
	cd PLOG_TP1_RI_$(CLASS)_$(GROUP) && zip ../$@ -r .
	rm -rf PLOG_TP1_RI_$(CLASS)_$(GROUP)

test:
	$(PROLOG) -q -l sample-states/initial.pl
	$(PROLOG) -q -l sample-states/intermediate.pl
	$(PROLOG) -q -l sample-states/final.pl

	$(PROLOG) -q -l sample-states/initial.pl      -a color
	$(PROLOG) -q -l sample-states/intermediate.pl -a color
	$(PROLOG) -q -l sample-states/final.pl        -a color

svg: img/initial_print_simple.svg img/intermediate_print_simple.svg img/final_print_simple.svg

img/%_print_simple.svg: img/%_print_simple.txt
	cd $(@D) && cat $(<F) | python3 printsimple2svg.py > $(@F)

img/%_print_simple.txt: img/%_print_simple.pl
	cd $(@D) && $(PROLOG) -q -l $(<F) > $(@F)

clean:
	rm *.zip

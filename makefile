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
	echo "halt." | $(PROLOG) -q -l sample-states/initial.pl
	echo "halt." | $(PROLOG) -q -l sample-states/intermediate.pl
	echo "halt." | $(PROLOG) -q -l sample-states/final.pl

clean:
	rm *.zip

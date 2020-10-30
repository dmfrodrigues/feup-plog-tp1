# To test with SICStus PROLOG, run make test PROLOG=sicstus
PROLOG=swipl

all:

test:
	echo "halt." | $(PROLOG) -q -l sample-states/initial.pl
	echo "halt." | $(PROLOG) -q -l sample-states/intermediate.pl
	echo "halt." | $(PROLOG) -q -l sample-states/final.pl

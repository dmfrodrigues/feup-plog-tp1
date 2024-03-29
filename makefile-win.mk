# (C) 2020 Diogo Rodrigues, Breno Pimentel
# Distributed under the terms of the GNU General Public License, version 3

# To test with SICStus PROLOG, run make test PROLOG=sicstus
PROLOG=swipl
CLASS=T2
GROUP=Glaisher4
ZIPNAME=PLOG_TP1_FINAL_$(CLASS)_$(GROUP)

SDIR=.\src
ODIR=.\obj

PROLOG_CMD=$(PROLOG) -f --noinfo -q

PARALLEL_CMD=
ifeq ($(PARALLEL),)
else
	PARALLEL_CMD=parallel
endif

all: $(ODIR)\lists.po $(ODIR)\choose_move_1.po $(ODIR)\choose_move_2.po $(ODIR)\choose_move_common.po

test: test_samples test_game_over test_move test_has_valid_moves test_value test_valid_moves test_maplist_multi test_choose_move

test_samples:
	$(PROLOG_CMD) -l sample-states/display_initial_state.pl
	$(PROLOG_CMD) -l sample-states/display_intermediate_state.pl
	$(PROLOG_CMD) -l sample-states/display_final_state.pl

	$(PROLOG_CMD) -l sample-states/display_initial_state.pl      -- color
	$(PROLOG_CMD) -l sample-states/display_intermediate_state.pl -- color
	$(PROLOG_CMD) -l sample-states/display_final_state.pl        -- color
	
test_game_over:
	$(PROLOG_CMD) -l tests/test_game_over/1.pl -- color
	$(PROLOG_CMD) -l tests/test_game_over/2.pl -- color
	$(PROLOG_CMD) -l tests/test_game_over/3.pl -- color
	$(PROLOG_CMD) -l tests/test_game_over/4.pl -- color

test_move:
	$(PROLOG_CMD) -l tests/test_move/1.pl -- color
	$(PROLOG_CMD) -l tests/test_move/2.pl -- color
	$(PROLOG_CMD) -l tests/test_move/3.pl -- color
	$(PROLOG_CMD) -l tests/test_move/4.pl -- color
	$(PROLOG_CMD) -l tests/test_move/5.pl -- color
	$(PROLOG_CMD) -l tests/test_move/6.pl -- color
	$(PROLOG_CMD) -l tests/test_move/7.pl -- color
	$(PROLOG_CMD) -l tests/test_move/8.pl -- color
	$(PROLOG_CMD) -l tests/test_move/9.pl -- color

test_has_valid_moves:
	$(PROLOG_CMD) -l tests/test_has_valid_moves/1.pl -- color
	$(PROLOG_CMD) -l tests/test_has_valid_moves/2.pl -- color
	$(PROLOG_CMD) -l tests/test_has_valid_moves/3.pl -- color

test_valid_moves:
	$(PROLOG_CMD) -l tests/test_valid_moves/1.pl -- color

test_value:
	$(PROLOG_CMD) -l tests/test_value/1.pl -- color
	$(PROLOG_CMD) -l tests/test_value/2.pl -- color
	$(PROLOG_CMD) -l tests/test_value/3.pl -- color
	$(PROLOG_CMD) -l tests/test_value/4.pl -- color
	$(PROLOG_CMD) -l tests/test_value/5.pl -- color
	$(PROLOG_CMD) -l tests/test_value/6.pl -- color

test_choose_move:
	$(PROLOG_CMD) -l tests/test_choose_move/1.pl -- color $(PARALLEL_CMD)
	$(PROLOG_CMD) -l tests/test_choose_move/2.pl -- color $(PARALLEL_CMD)
	$(PROLOG_CMD) -l tests/test_choose_move/3.pl -- color $(PARALLEL_CMD)
	$(PROLOG_CMD) -l tests/test_choose_move/4.pl -- color $(PARALLEL_CMD)
	$(PROLOG_CMD) -l tests/test_choose_move/5.pl -- color $(PARALLEL_CMD)
	$(PROLOG_CMD) -l tests/test_choose_move/6.pl -- color $(PARALLEL_CMD)

test_maplist_multi:
	$(PROLOG_CMD) -l tests/test_maplist_multi/1.pl -- color $(PARALLEL_CMD)

$(ODIR)\choose_move_common.po: $(SDIR)\choose_move_common.pl | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo consult('build_choose_move_common_po.pl'). | $(PROLOG)
else
	exit 1
endif

$(ODIR)\choose_move_1.po: $(SDIR)\choose_move_1.pl | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo consult('build_choose_move_1_po.pl'). | $(PROLOG)
else
	exit 1
endif

$(ODIR)\choose_move_2.po: $(SDIR)\choose_move_2.pl | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo consult('build_choose_move_2_po.pl'). | $(PROLOG)
else
	exit 1
endif

$(ODIR)\lists.po: | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo use_module(library(lists)), save_modules([lists], './obj/lists'). | $(PROLOG)
else
	exit 1
endif

$(ODIR):
	mkdir $(ODIR)

clean:
	del /f *.zip
	rmdir $(ODIR) /s /q

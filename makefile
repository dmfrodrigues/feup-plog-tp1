# (C) 2020 Diogo Rodrigues, Breno Pimentel
# Distributed under the terms of the GNU General Public License, version 3

# To test with SICStus PROLOG, run make test PROLOG=sicstus
SHELL := /bin/bash

PROLOG=swipl
CLASS=T2
GROUP=Glaisher4
ZIPNAME=PLOG_TP1_FINAL_$(CLASS)_$(GROUP)

SDIR=./src
ODIR=./obj

PROLOG_CMD=$(PROLOG) -f --noinfo -q

PARALLEL_CMD=
ifeq ($(PARALLEL),)
else
	PARALLEL_CMD=parallel
endif

all: $(ODIR)/lists.po $(ODIR)/choose_move_1.po $(ODIR)/choose_move_2.po $(ODIR)/choose_move_common.po

zip: $(ZIPNAME).zip

$(ZIPNAME).zip:
	rm -rf $(ZIPNAME)
	mkdir -p $(ZIPNAME)
	cp -r img prolog-multiprocessing sample-states src tests build_choose_move_1_po.pl build_choose_move_2_po.pl build_choose_move_common_po.pl LICENSE makefile makefile-win.mk README.md $(ZIPNAME)
	cd $(ZIPNAME) && zip ../$@ -r .
	rm -rf $(ZIPNAME)

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
	$(PROLOG_CMD) -l tests/test_choose_move/7.pl -- color $(PARALLEL_CMD)

test_maplist_multi:
	$(PROLOG_CMD) -l tests/test_maplist_multi/1.pl -- color $(PARALLEL_CMD)

test_server_local:
	(swipl -l server.pl -g "http_server([port(8081)])" -g "thread_get_message(_)" -- $(PARALLEL_CMD))&
	sleep 2
	make test_server TEST_URL="localhost:8081"
	kill -9 $$(pgrep "swipl")

test_server_heroku:
	make test_server TEST_URL="https://feup-plog-tp1-staging.herokuapp.com/"

test_server:
	curl -d '{"command":"hello","args":{}}' -H "Content-Type: application/json" -X POST $(TEST_URL)
	@echo
	curl -d '{"command": "move", "args": { "board": [[  0,  6,  0,  0,  0,"nan","nan","nan","nan"],[  0,  0,  0,  0,  0, -6,"nan","nan","nan"],[  0,  0,  0,  0,  0,  0,  0,"nan","nan"],[ -6,  0,  0,  0,  0,  0,  0,  0,"nan"],[  0,  0,  0,  0,  0,  0,  0,  0,  0],["nan",  0,  0,  0,  0,  0,  0,  0,  6],["nan","nan",  0,  0,  0,  0,  0,  0,  0],["nan","nan","nan",  6,  0,  0,  0,  0,  0],["nan","nan","nan","nan",  0,  0,  0, -6,  0]], "playermove": { "player": 1, "pos": [0,1], "substacks": [1,2,3], "dir": 6, "newpos": [0,0]}}}' -H "Content-Type: application/json" -X POST $(TEST_URL)
	@echo
	curl -d '{"command": "choose_move", "args": { "gamestate": { "board": [[  0,  6,  0,  0,  0,"nan","nan","nan","nan"],[  0,  0,  0,  0,  0, -6,"nan","nan","nan"],[  0,  0,  0,  0,  0,  0,  0,"nan","nan"],[ -6,  0,  0,  0,  0,  0,  0,  0,"nan"],[  0,  0,  0,  0,  0,  0,  0,  0,  0],["nan",  0,  0,  0,  0,  0,  0,  0,  6],["nan","nan",  0,  0,  0,  0,  0,  0,  0],["nan","nan","nan",  6,  0,  0,  0,  0,  0],["nan","nan","nan","nan",  0,  0,  0, -6,  0]], "turn": 1 }, "turn": 1, "level": 3, "n": 7}}' -H "Content-Type: application/json" -X POST $(TEST_URL)
	@echo
	curl -d '{"command": "value", "args": { "gamestate": { "board": [[  0,  6,  0,  0,  0,"nan","nan","nan","nan"],[  0,  0,  0,  0,  0, -6,"nan","nan","nan"],[  0,  0,  0,  0,  0,  0,  0,"nan","nan"],[ -6,  0,  0,  0,  0,  0,  0,  0,"nan"],[  0,  0,  0,  0,  0,  0,  0,  0,  0],["nan",  0,  0,  0,  0,  0,  0,  0,  6],["nan","nan",  0,  0,  0,  0,  0,  0,  0],["nan","nan","nan",  6,  0,  0,  0,  0,  0],["nan","nan","nan","nan",  0,  0,  0, -6,  0]], "turn": 1 }, "turn": 1}}' -H "Content-Type: application/json" -X POST $(TEST_URL)
	@echo
	curl -d '{"command": "game_over", "args": { "gamestate": { "board": [[  0,  6,  0,  0,  0,"nan","nan","nan","nan"],[  0,  0,  0,  0,  0, -6,"nan","nan","nan"],[  0,  0,  0,  0,  0,  0,  0,"nan","nan"],[ -6,  0,  0,  0,  0,  0,  0,  0,"nan"],[  0,  0,  0,  0,  0,  0,  0,  0,  0],["nan",  0,  0,  0,  0,  0,  0,  0,  6],["nan","nan",  0,  0,  0,  0,  0,  0,  0],["nan","nan","nan",  6,  0,  0,  0,  0,  0],["nan","nan","nan","nan",  0,  0,  0, -6,  0]],"turn":1}}}' -H "Content-Type: application/json" -X POST $(TEST_URL)
	@echo
	curl -d '{"command": "game_over", "args": { "gamestate": { "board": [ [ -1,  0, -1,  0,  1,"nan","nan","nan","nan"],[  0,  0, -1,  0,  0,  0,"nan","nan","nan"],[  0,  0,  0, -6,  0,  3,  1,"nan","nan"],[  0,  0,  2,  3,  5,  1,  0,  0,"nan"],[  1,  2,  1,  0, -3,  0,  0,  0,  0],["nan",  0, -3, -1, -3,  0,  0,  0,  0],["nan","nan",  0, -1,  0,  2,  0,  0,  0],["nan","nan","nan", -1,  0,  0,  0,  1,  0],["nan","nan","nan","nan",  0,  0,  0,  0,  0]],"turn":1}}}' -H "Content-Type: application/json" -X POST $(TEST_URL)
	@echo

$(ODIR)/choose_move_common.po: $(SDIR)/choose_move_common.pl | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo "consult('build_choose_move_common_po.pl')." | $(PROLOG)
else
	exit 1
endif

$(ODIR)/choose_move_1.po: $(SDIR)/choose_move_1.pl | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo "consult('build_choose_move_1_po.pl')." | $(PROLOG)
else
	exit 1
endif

$(ODIR)/choose_move_2.po: $(SDIR)/choose_move_2.pl | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo "consult('build_choose_move_2_po.pl')." | $(PROLOG)
else
	exit 1
endif

$(ODIR)/lists.po: | $(ODIR)
ifeq ($(PROLOG),sicstus)
	echo "use_module(library(lists)), save_modules([lists], '$(ODIR)/lists')." | $(PROLOG)
else
	exit 1
endif

$(ODIR):
	mkdir -p $(ODIR)

svg: img/initial_print_simple.svg img/intermediate_print_simple.svg img/final_print_simple.svg

img/%_print_simple.svg: img/%_print_simple.json
	cd $(@D) && cat $(<F) | python3 printsimple2svg.py > $(@F)

img/%_print_simple.json: img/%_print_simple.pl
	cd $(@D) && $(PROLOG) -q -l $(<F) > $(@F)

clean:
	rm -f *.zip *.sav *.po
	rm -rf $(ODIR)

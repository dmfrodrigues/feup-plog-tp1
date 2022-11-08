#!/bin/bash
swipl -l server.pl -g "http_server([port($1)])" -g "thread_get_message(_)" -- PARALLEL_CMD=parallel

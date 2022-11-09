#!/bin/bash
if [ -z "$2"]
then
    swipl -l server.pl -g "http_server([port($1)])" -g "thread_get_message(_)"
else
    swipl -l server.pl -g "http_server([port($1)])" -g "thread_get_message(_)" -- PARALLEL_CMD=parallel
fi

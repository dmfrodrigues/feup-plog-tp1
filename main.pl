:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

:- http_handler(/, root_handler, []).

root_handler(_):-
    format('Content-Type: text/html~n~n', []),
    format('Hello from Prolog').

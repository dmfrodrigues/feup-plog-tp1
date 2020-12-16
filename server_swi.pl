:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json)).

:- set_setting(http:cors, [*]).

:- current_predicate(http_handler/3) -> true ; use_module(library(http/http_server)).
:- http_handler(/, server, [methods([post, options])]).

% Handle preflight OPTIONS request
server(Request) :-
    option(method(options), Request), !,
    cors_enable(Request, [methods([post, options])]),
    format('~n').

server(Request) :-
    cors_enable,
    http_read_json(Request, JSON),
    handle_request(JSON, Response, Status),
    format(current_output, 'Status: ~s~n', [Status]),
    format(current_output, 'Content-Type: application/json~n~n', []),
    json_write(current_output, Response, [width(60)]).

:-
	reconsult('server_common.pl').

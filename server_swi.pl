:- use_module(library(http/http_server)).
% :- use_module(library(codesio)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json)).

:- http_handler(/, server, [method(post)]).

% Handle preflight OPTIONS request
server(Request) :-
    option(method(options), Request), !,
    cors_enable(
        Request,
        [
            methods([post])
        ]
    ),
    format('~n').                           % 200 with empty body

server(Request) :-
    format(current_output, 'Access-Control-Allow-Origin: *~n', []),
    http_read_json(Request, JSON),
    handle_request(JSON, Response, Status),
    format(current_output, 'Status: ~s~n', [Status]),
    format(current_output, 'Content-Type: application/json~n~n', []),
    json_write(current_output, Response, [width(60)]).

:-
	reconsult('server_common.pl').

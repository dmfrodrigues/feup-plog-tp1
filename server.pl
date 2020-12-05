% (C) 2020-2021 Diogo Rodrigues, Breno Pimentel
% Distributed under the terms of the GNU General Public License, version 3
% Inspired by the work of Luis Reis (ei12085@fe.up.pt) for LAIG course at FEUP.

:-
	(current_prolog_flag(dialect, sicstus), reconsult('server_sicstus.pl'));
	(current_prolog_flag(dialect, swi    ), reconsult('server_swi.pl')).

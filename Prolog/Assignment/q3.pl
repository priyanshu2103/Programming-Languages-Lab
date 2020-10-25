% All undirected edges(and their weights) in the graph.
weight(g1, g5, 4).
weight(g2, g5, 6).
weight(g3, g5, 8).
weight(g4, g5, 9).
weight(g1, g6, 10).
weight(g2, g6, 9).
weight(g3, g6, 3).
weight(g4, g6, 5).
weight(g5, g7, 3).
weight(g5, g10, 4).
weight(g5, g11, 6).
weight(g5, g12, 7).
weight(g5, g6, 7).
weight(g5, g8, 9).
weight(g6, g8, 2).
weight(g6, g12, 3).
weight(g6, g11, 5).
weight(g6, g10, 9).
weight(g6, g7, 10).
weight(g7, g10, 2).
weight(g7, g11, 5).
weight(g7, g12, 7).
weight(g7, g8, 10).
weight(g8, g9, 3).
weight(g8, g12, 3).
weight(g8, g11, 4).
weight(g8, g10, 8).
weight(g10, g15, 5).
weight(g10, g11, 2).
weight(g10, g12, 5).
weight(g11, g15, 4).
weight(g11, g13, 5).
weight(g11, g12, 4).
weight(g12, g13, 7).
weight(g12, g14, 8).
weight(g15, g13, 3).
weight(g13, g14, 4).
weight(g14, g17, 5).
weight(g14, g18, 4).
weight(g17, g18, 8).

edge(N, N1, D) :- weight(N, N1, D).
edge(N1, N, D) :- weight(N1, N, D).

% valid start points.
check_if_start(Ver) :- Ver = g1.
check_if_start(Ver) :- Ver = g2.
check_if_start(Ver) :- Ver = g3.
check_if_start(Ver) :- Ver = g4.

% Check for valid path, given the nodes in the path sequence.
valid(R) :- 
	R = [R0|R1], 
	check_if_start(R0), 
	check_valid(R0, R1).

% Recursively check the valid edges.
check_valid(g17, []).
check_valid(R0, R) :- 
	R = [R1|R2], 
	weight(R0, R1, _), 
	check_valid(R1, R2);R = [R1|R2], weight(R1, R0, _),
	check_valid(R1, R2).

% Find all possible paths, by just ignoring the weights and appending valid edge nodes.
possible_paths(g17, V) :- writeln(V).

possible_paths(N, V) :- 
	N \= g17,
	weight(N, N1, _),
	\+member(N1, V),
	append(V, [N1], V1), possible_paths(N1, V1).

possible_paths(N, V) :-
	N \= g17,
	weight(N1, N, _),
	\+member(N1, V),
	append(V, [N1], V1),
	possible_paths(N1, V1).

list_min([L|Ls], Min) :- foldl(num_num_min, Ls, L, Min).

num_num_min(X, Y, Min) :- Min is min(X, Y).

% Find all paths for the given path length val.

all_paths_with_length(g17, V, 0) :- writeln(V).

all_paths_with_length(N, V, Min) :- 
	N \= g17, 
	weight(N, N1, D), 
	\+member(N1, V), 
	append(V, [N1], V1), 
	Val1 is Min - D, 
	all_paths_with_length(N1, V1, Val1).

all_paths_with_length(N, V, Min) :-
	N \= g17, 
	weight(N1, N, D), 
	\+member(N1, V), 
	append(V, [N1], V1), 
	Val1 is Min - D, 
	all_paths_with_length(N1, V1, Val1).


paths_with_length(Val) :- 
	check_if_start(R),
	all_paths_with_length(R, [R], Val).

%Finf optimal path starting from N, visited nodes in V, for total path length Val.
best_path_calc(g17, _, 0).

best_path_calc(N, V, Val) :- 
	N \= g17, 
	edge(N, N1, D),
	\+member(N1, V), 
	append(V, [N1], V1), 
	best_path_calc(N1, V1, Val1), 
	Val is Val1 + D.

best_path(Len) :- 
	check_if_start(Ver), 
	best_path_calc(Ver, [Ver], Len).

all_possible_paths() :- 
	check_if_start(R),
	possible_paths(R, [R]).

print_weight(Z):-
	format("Weight of Path: ~w ~n",[Z]).

% Get optimal path over all possible paths; recursing over all valid paths with length Val.
optimum_path() :- 
	findall(Len, best_path(Len), Dist),
	list_min(Dist, MinDist), 
	write("The following paths are the shortest:"),
	nl,
	paths_with_length(MinDist),
	print_weight(MinDist).
% Distances between every gate in the prison
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

check_if_empty([]).										% checks if a list is empty

display_path(_,[]).

% if we have only 2 nodes remaining, print them
display_path(FirstVert, [SecondVert|Rest]):-
	check_if_empty(Rest),
	write(FirstVert),
	writeln(SecondVert).

% recursive utility function which prints path
display_path(FirstVert, [SecondVert|Rest]):-
	\+ check_if_empty(Rest),
	format("~w~w -> ", [FirstVert, SecondVert]),
	display_path("", Rest).
 
% edge between 2 gates A and B exist if we have entry A->B or B->A in the knowledge base
edge(Vertex, Vertex1, W) :- weight(Vertex, Vertex1, W).
edge(Vertex, Vertex1, W) :- weight(Vertex1, Vertex, W).

% prisoners can start their escape from gates g1,g2,g3,g4
start(g1).
start(g2).
start(g3).
start(g4).

% base case
is_valid_path(g17, []).

% iteratively checks if a path exist from a given gate to the rest of the gates
is_valid_path(Src, Path) :- 
	Path = [Vert|Rest], 								% break down the path into first gate and rest of the gates
	edge(Src, Vert, _),									% a edge should exist between given gate and first gate of path
	is_valid_path(Vert, Rest).							% check if a path exist from this first gate to rest gates

% checks the validity of a path
is_valid_path(Path) :- 
	Path = [Src|Rest], 									% break down the path into first gate and rest of the gates
	start(Src),											% first gate should be one of g1, g2, g3, g4
	is_valid_path(Src, Rest).							% check for validity of a path beginning from a given vertex

% this predicate checks the validity of a given path
check_path_validity(Path) :-
	is_valid_path(Path)
	->(   
		writeln('Valid Path')	                        
	)
	;(
		writeln('Invalid Path')
	). 

% base case of recursion, prints the path
build_path(g17, Visited) :- 
	display_path("Path: ",Visited).

% recursively builds a valid path from given a given gate and already visited gates
build_path(Vertex, Visited) :- 
	Vertex \= g17,
	edge(Vertex, Vertex1, _),
	\+member(Vertex1, Visited),
	append(Visited, [Vertex1], VisitedNew), 
	build_path(Vertex1, VisitedNew).

% this predicate prints all the valid paths of every length
find_all_paths() :- 
	writeln("The following paths are the valid for escaping:"),
	start(Vertex),
	build_path(Vertex, [Vertex]),
	fail().

% base case of recursion, print the visited list
build_path(g17, Visited, 0) :- 
	display_path("Path: ",Visited).

% recursively finding a path from vertex with a given length
build_path(Vertex, Visited, Len) :- 
	Vertex \= g17, 
	edge(Vertex, Vertex1, W),							% W is the distance between the two gates
	\+member(Vertex1, Visited), 
	append(Visited, [Vertex1], VisitedNew), 
	Len1 is Len - W,									% path from new vertex has to be of length Len - W 
	build_path(Vertex1, VisitedNew, Len1).				% build a path from new vertex with the new given length

% prints all the valid paths of a given length
paths_with_length(Len) :- 
	start(Vertex),										% path should begin from either g1, g2, g3, g4
	build_path(Vertex, [Vertex], Len).					% build a path starting from vertex and having given length

optimum_path_calc(g17, _, 0).							% base case of recursion

% recursively calculate the best path from Vertex with a given length
optimum_path_calc(Vertex, Visited, Len) :- 
	Vertex \= g17, 										% g17 is the end gate
	edge(Vertex, Vertex1, W),							% check if there is a gate connected from Vertex
	\+member(Vertex1, Visited), 						% new gate should not be a visited one
	append(Visited, [Vertex1], VisitedNew), 			% add this new gate to the visited list
	optimum_path_calc(Vertex1, VisitedNew, Len1), 		% calculate the best path from this new gate
	Len is Len1 + W.									% length of the best path is length from new gate plus distance between gates

% finds the best path of a given length
best_path(Len) :- 
	start(Vertex),										% path should begin from either g1, g2, g3, g4
	optimum_path_calc(Vertex, [Vertex], Len).			% finds the best path of a given length beginning from Vertex

% prints the weight of path
print_weight(MinDist):-
	format("Weight of Path: ~w ~n", [MinDist]).

% this predicate prints the optimum path
optimum_path() :- 
	findall(Len, best_path(Len), Dist),					% find all best paths of various lengths
	min_list(Dist, MinDist),							% finds the minimum value from Dist list
	writeln("The following paths are the shortest:"),
	paths_with_length(MinDist),							% utility predicate to print the shortest path
	print_weight(MinDist).								% prints the shortest path length
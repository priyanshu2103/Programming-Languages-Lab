% knowledge base
% Bus (Number, Origin, Destination Place, Departure Time, Arrival Time, Distance, Cost) -> Kota Map!
bus(1, 'Sakatpura', 'Gumanpura', 14.5, 15, 10, 10).
bus(2, 'Sakatpura', 'CAD', 14.5, 15, 8, 9).
bus(3, 'Sakatpura', 'Nayapura', 14.5, 15, 9, 8).
bus(4, 'Gumanpura', 'Rampura', 15, 15.5, 5, 5).
bus(5, 'CAD', 'Talwandi', 15, 15.5, 10, 8).
bus(6, 'Talwandi', 'Anantnagar', 15.5, 16.5, 15, 15).
bus(7, 'Nayapura', 'Station', 16, 16.5, 10, 8).
bus(8, 'CAD', 'Station', 16, 17, 5, 2).

edge(Id, Src, Dst, Time, 'Time') :-              % checks if an edge exists between Source and Dest with weight Time
	bus(Id, Src, Dst, T1, T2, _, _), 
	Time is T2-T1.                            % T2 is arrival and T1 is departure time

edge(Id, Src, Dst, Dist, 'Distance') :-          % checks if an edge exists between Source and Dest with distance Dist
	bus(Id, Src, Dst, _, _, Dist, _).

edge(Id, Src, Dst, Cost, 'Cost') :-              % checks if an edge exists between Source and Dest with cost Cost
	bus(Id, Src, Dst, _, _, _, Cost).


constructpath(A, B, Path, Length, Type) :-                % constructs a path if it exists from A to B
       % checks if B can be reached from A, or if there is a C reachable from A that connects to B
       populatepaths(A, B, [A], Q, Length, Type),       
       reverse(Q, Path).

populatepaths(A, B, Path, [B, Id|Path], Length, Type) :-    % calls the edge predicate to check if B can be reached from A
       edge(Id, A, B, Length, Type).

% A is connected to B, if A is connected to location C that is still not visited and which is different from B
% and one can recursively find path from C to B
populatepaths(A, B, Visited, Path, Length, Type) :-
       edge(Id, A, C, D, Type),           
       C \== B,
       \+member(C, Visited),                     % checks membership of C in Visited list
       populatepaths(C, B, [C, Id|Visited], Path, Len, Type),
       Length is D + Len.  

% util that finds minimum length path among all the paths
minimalPath([F|R], M) :- min(R, F, M).

% minimal path
min([], M, M).
min([[P,L]|R], [_,M], Min) :- L < M, !, min(R, [P,L], Min). 
min([_|R], M, Min) :- min(R, M, Min).

% calculates the shortest path of a particular type between Source and Destination
shortest(Src, Dst, Path, Length, Type) :-
       % setof is an inbuilt predicate(setof/3) which builds a set 'allPaths' consisting of Path, Length
       % (unique entries) in a sorted manner
       setof([Path, Length], constructpath(Src, Dst, Path, Length, Type), Allpaths),
       Allpaths = [_|_],                         % fail if no path                         
       minimalPath(Allpaths, [Path,Length]).     % finds the minimum length path

% calculates shortest path and prints it
routeType(Src, Dst, Pathtype) :-
	shortest(Src, Dst, Shortestpath, Shortestdist, Pathtype),   
	writef('Optimum path is %w with %w = %w\n', [Shortestpath, Pathtype, Shortestdist]).

% checks if route exists, if "Yes" prints the route of different types, if "No" output no path
checkRouteExist(Src, Dst) :-
       shortest(Src, Dst, Shortestpath, Shortestdist, 'Distance')     % predicate which calculates shortes path
       -> (   
              routeType(Src, Dst, 'Distance'),   % calculates shortest path in terms of distance and prints it                        
              routeType(Src, Dst, 'Time'),       % calculates shortest path in terms of time and prints it
              routeType(Src, Dst, 'Cost')        % calculates shortest path in terms of cost and prints it
	  )
	;(
              writef('No path exists between %w and %w\n', [Src, Dst])
       ). 


route(Src, Dst) :- checkRouteExist(Src, Dst).          % checks if route exists

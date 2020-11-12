% knowledge base
% Bus (Number, Origin, Destination Place, Departure Time, Arrival Time, Distance, Cost) -> Kota Map!
bus(1, 'Sakatpura', 'Gumanpura', 14.5, 15.5, 7, 10).
bus(2, 'Nayapura', 'CAD', 16.5, 18, 7, 8).
bus(3, 'Gumanpura', 'Talwandi', 15, 16, 3, 6).
bus(4, 'Talwandi', 'Station', 17, 18, 2, 16).
bus(5, 'Gumanpura', 'Station', 16, 17, 21, 7).
bus(6, 'Rampura', 'Nayapura', 15, 16.5, 5, 7).
bus(7, 'Station', 'Nayapura', 16, 16.5, 4, 6).
bus(8, 'CAD', 'Sakatpura', 18, 19.5, 16, 10).
bus(9, 'Nayapura', 'Talwandi', 15, 17, 15, 25).

% checks if an edge exists between Source and Dest with weight Time and this is the first bus
edge(Id, Src, Dst, Time, 'Time', Prev_time, Next_time) :-              
	bus(Id, Src, Dst, T1, T2, _, _),          % T2 is arrival and T1 is departure time
       Prev_time == 0,
       Time is T2-T1,
       Next_time is T2.

% checks if an edge exists between Source and Dest with weight Time and next bus exist within same day
edge(Id, Src, Dst, Time, 'Time', Prev_time, Next_time) :-              
	bus(Id, Src, Dst, T1, T2, _, _),          % T2 is arrival and T1 is departure time
       Prev_time =< T1,
       Time is T2-Prev_time,
       Next_time is T2.

% checks if an edge exists between Source and Dest with weight Time and next bus can't be caught in the same day
edge(Id, Src, Dst, Time, 'Time', Prev_time, Next_time) :-              
	bus(Id, Src, Dst, T1, T2, _, _),          % T2 is arrival and T1 is departure time
       Prev_time > T1,
       Time is T2-T1+24,
       Next_time is T2.

% checks if an edge exists between Source and Dest with distance Dist
edge(Id, Src, Dst, Dist, 'Distance', Prev_time, Next_time) :-          
       bus(Id, Src, Dst, _, _, Dist, _).

% checks if an edge exists between Source and Dest with cost Cost
edge(Id, Src, Dst, Cost, 'Cost', Prev_time, Next_time) :-              
       bus(Id, Src, Dst, _, _, _, Cost).


constructpath(A, B, Path, Length, Type) :-       % constructs a path if it exists from A to B
       % checks if B can be reached from A, or if there is a C reachable from A that connects to B
       populatepaths(A, B, [A], Q, Length, Type, 0, _),       
       reverse(Q, Path).

% calls the edge predicate to check if B can be reached from A
populatepaths(A, B, Path, [B, Id|Path], Length, Type, Prev_time, Next_time) :-    
       edge(Id, A, B, Length, Type, Prev_time, Next_time).

% A is connected to B, if A is connected to location C that is still not visited and which is different from B
% and one can recursively find path from C to B
populatepaths(A, B, Visited, Path, Length, Type, Prev_time, Next_time) :-
       edge(Id, A, C, D, Type, Prev_time, Next_time),           
       C \== B,
       \+member(C, Visited),                     % checks membership of C in Visited list
       populatepaths(C, B, [C, Id|Visited], Path, Len, Type, Next_time, _),
       Length is D + Len.  

% util that finds minimum length path among all the paths
minimalPath([Front|Rear], Mid) :- min(Rear, Front, Mid).

% minimal path calculation from the set
min([], Mid, Mid).
min([[P,L]|Rear], [_,Mid], Min) :- L < Mid, !, min(Rear, [P,L], Min). 
min([_|Rear], Mid, Min) :- min(Rear, Mid, Min).

% calculates the shortest path of a particular type between Source and Destination
shortest(Src, Dst, Path, Length, Type) :-
       % setof is an inbuilt predicate(setof/3) which builds a set 'allPaths' consisting of Path, Length
       % (unique entries) in a sorted manner
       setof([Path, Length], constructpath(Src, Dst, Path, Length, Type), Allpaths),
       Allpaths = [_|_],                         % fail if no path                         
       minimalPath(Allpaths, [Path,Length]).     % finds the minimum length path

% utility function to print the corresponding distance, time, cost given the shortest path
printPathDistance([A,B,C|T], Distance, Time, Cost, YourArrivalTime) :-
       edge(B, A, C, D, 'Distance', _, _),
       edge(B, A, C, Duration, 'Time', YourArrivalTime, Arrival),
       edge(B, A, C, Cos, 'Cost', _, _),
       NewDistance is D + Distance,          % compute distance, cost  and duration so far
       NewCost is Cost + Cos,
       NewTime is Time + Duration,
       printPathDistance([C|T], NewDistance, NewTime, NewCost, Arrival). 
 
% base case, print the distances found
printPathDistance([A|[]], Distance, Time, Cost, _) :- format('Distance: ~w, Time: ~w, Cost: ~w~n', [Distance, Time, Cost]).

% calculates shortest path and prints it
routeType(Src, Dst, Pathtype) :-
	shortest(Src, Dst, Shortestpath, Shortestdist, Pathtype),   
	writef('Optimum path with shortest %w is %w \n', [Pathtype, Shortestpath]),
       printPathDistance(Shortestpath, 0, 0, 0, 0).


% checks if route exists, if "Yes" prints the route of different types, if "No" output no path
checkRouteExist(Src, Dst) :-
       shortest(Src, Dst, Shortestpath, Shortestdist, 'Distance')     % predicate which calculates shortes path
       -> (   
              routeType(Src, Dst, 'Distance'),   % calculates shortest path in terms of distance and prints it                        
              routeType(Src, Dst, 'Time'),       % calculates shortest path in terms of time and prints it
              routeType(Src, Dst, 'Cost'),        % calculates shortest path in terms of cost and prints it
              !
	  )
	;(
              writef('No path exists between %w and %w\n', [Src, Dst])
       ). 


route(Src, Dst) :- checkRouteExist(Src, Dst).          % checks if route exists     

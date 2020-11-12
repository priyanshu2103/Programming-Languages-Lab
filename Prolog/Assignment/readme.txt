PRIYANSHU SINGH 170101049

1.  Run "swipl -s q1.pl"
    (a) to query, run "uncle(katappa, avantika)."
        for queries like "uncle(A,B)." , the output will be of the following format:-
        A = katappa,
        B = avantika
        To see more possible values of A and B, press ";"

    (b) to query, run "halfsister(avantika, shivkami)."
        Rest same as that of (a)

2.  For this question, I have created a knowledge base of buses in my city. 
    The query should be of the form, "route(X, Y)" where X and Y are regions in knowledge base

    Ex:     "route('Sakatpura', 'Station')." prints
            Optimum path with shortest Distance is [Sakatpura,1,Gumanpura,3,Talwandi,4,Station] 
            Distance: 12, Time: 28.0, Cost: 32
            Optimum path with shortest Time is [Sakatpura,1,Gumanpura,5,Station] 
            Distance: 28, Time: 2.5, Cost: 17
            Optimum path with shortest Cost is [Sakatpura,1,Gumanpura,5,Station] 
            Distance: 28, Time: 2.5, Cost: 17

            Here "Sakatpura,1,Gumanpura" means that bus ID 1 from Sakatpura to Gumanpura is taken
            Notice that the total time taken "includes" the waiting time between bus stops

            "route('Sakatpura', 'Stations')." prints "No path exists between Sakatpura and Stations"


3.  Run "swipl -s q3.pl"
    (a) to query, run "find_all_paths."
        All the possible paths will be displayed that lead to escape from jail

    (b) to query, run "optimum_path()."
        The query would print the optimum path and prints the weight of the path 

    (c) to query, run "check_path_validity(Path)" where Path is a list of comma separated vertices
        Example :- "check_path_validity([g4, g6, g5, g8, g7, g12, g11, g10, g15, g13, g14, g18, g17])." gives output as
        "Valid Path"
        Note :- Cyclic vertices that are correct path is considered as it will lead to freedom from jail.
% knowledge base
parent(jatin,avantika).
parent(jolly,jatin).
parent(jolly,katappa).
parent(manisha,avantika).
parent(manisha,shivkami).
parent(bahubali,shivkami).

male(katappa).
male(jolly).
male(bahubali).

female(shivkami).
female(avantika).

bloodbrother(A,B) :- male(A), parent(Z,A), parent(Z,B).     % blood brothers have atleast one parent common

%half sisters would have only 1 parent common
halfsister(A,B) :- female(A), parent(Z,A), parent(Z,B), parent(X,A), parent(Y,B), A\=B, X\=Y, Z\=X, Z\=Y. 

uncle(A,B) :- parent(Z,B), bloodbrother(A,Z).               % A is uncle of B if B is blood brother of A's parent


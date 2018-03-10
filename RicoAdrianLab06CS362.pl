
% finds a hitting set for the conflict sets.

subseq([],[]).
subseq([Item | RestX], [Item | RestY]) :-subseq(RestX,RestY).
subseq(X, [_ | RestY]) :-subseq(X,RestY).

contains([Head|Tail],X) :-
	 Head = X;
	contains(Tail,X).

solutionLength(1).
solutionLength(X) :- solutionLength(Y), X is Y+1.

union([], L, L).
union([Head|L1tail], L2, L3) :-
        memberchk(Head, L2),
        !,
        union(L1tail, L2, L3).
union([Head|L1tail], L2, [Head|L3tail]) :-
        union(L1tail, L2, L3tail).

checkHittingSet([],_).
checkHittingSet([Head|Tail],List) :- member(X,List), contains(Head,X), checkHittingSet(Tail,List).

mergesort(In,Out):-
  split(In,L,R),
  mergesort(L,L2),
  mergesort(R,R2),
  merge(L2,R2,Out).

split([],[],[]).
split([A,B|T],[A|L],[B|R]):-
split(T,L,R).

merge([],R,R).
merge(L,[],L).
merge([A|L],[B|R],[A|Z]):-
  A <= B,
  merge(L,[B|R],Z).
merge([A|L],[B|R],[B|Z]):-
  A > B,
merge([A|L],R,Z).
  
minHittingSet(Sets, Solution) :-solutionLength(X),ord_union(Sets, Combine),subseq(Solution, Combine), checkHittingSet(Sets,Solution), length(Solution,X),!.
	
	
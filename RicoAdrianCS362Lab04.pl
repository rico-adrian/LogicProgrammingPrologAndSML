
median(A,B,C,X) :-
	A>=B, A=<C -> X=A;
	A>=C, A=<B -> X=A.
median(A,B,C,X) :-
	B>=A, B=<C -> X=B;
	B>=C, B=<A ->X=B.
median(A,B,C,X) :-
	C>=A, C=<B -> X=C;
	C>=B, C=<A -> X=C.
	
largerEqual([],_).
largerEqual([Head|Tail],X) :-
	Head=<X, largerEqual(Tail,X).	

contains([Head|Tail],X) :-
	 Head=X;
	contains(Tail,X).

max(L,X) :-
	contains(L,X), largerEqual(L,X).
	
	
	
	
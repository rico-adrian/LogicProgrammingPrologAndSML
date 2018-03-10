% bridge.pl
% Aswin F. van Woudenberg

print_all_solutions :-
	findall(_,print_solution,_).

print_solution :- 
  init(State), 
  solve(State,Solution,EndState), 
  writeln('Start state:'),
  writeln(State),
  writeln('Solution:'),
  writeln(Solution),
  writeln('Final state:'),
  writeln(EndState), nl.

solve(State,[],State) :- goal(State).
solve(State,[Move|Tail],EndState) :- s(State,Move,NewState),solve(NewState,Tail,EndState).

goal(state([],right,[_,_,_,_],T)) :- T =< 18.

init(state([adam,brianna,rico,diana],left,[],0)).

s(state(L1,left,L2,T),cross_bridge(L3),state(L4,right,L6,T2)) :- 
  select_one_or_two(L1,L3,L4),append(L2,L3,L5),sort(L5,L6),min_time_needed(L3,Tn),T2 is T + Tn, T2 =< 18.
s(state(L1,right,L2,T),cross_bridge(L3),state(L4,left,L6,T2)) :- 
  select_one_or_two(L2,L3,L5),append(L1,L3,L4),sort(L5,L6),min_time_needed(L3,Tn),T2 is T + Tn, T2 =< 18.

select_one_or_two(L,[Sel],L2) :- select(Sel,L,L2).
select_one_or_two(L,[Sel1,Sel2],L2) :- select(Sel1,L,NewL),select(Sel2,NewL,L2),Sel1@<Sel2.

min_time_needed([A],T) :- time_needed(A,T).
min_time_needed([A,B],T1) :- time_needed(A,T1), time_needed(B,T2), T1 >= T2.
min_time_needed([A,B],T2) :- time_needed(A,T1), time_needed(B,T2), T1 < T2.

time_needed(adam,1).
time_needed(brianna,2).
time_needed(rico,5).
time_needed(diana,10).
	
	
	
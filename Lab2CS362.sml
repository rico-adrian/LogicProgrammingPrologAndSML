fun last(lst)=
if lst=[hd lst] then hd lst
else last(tl lst);

fun middle(lst)=
let
fun help(m,lst')=
case(m,lst') of
(x::xs,[])=>x
|(x::xs,[y])=>x
|(x::xs,y::y2::ys)=>help(xs,ys)
|_=>raise Fail "SML compiler error"
in
case lst of
[]=> raise Fail "can't find the middle of empty list"
|x::xs=>help(lst,xs)
end;

fun median(a,b,c)=
if(a<b andalso b<c) orelse (a>b andalso b>c) then b
else if (b>a andalso c<a) orelse (a>b andalso a<c) then a
else c;

fun partition([],pivot)=([],[])
|partition(h::t,pivot)=
let val(smalls,bigs)=partition(t,pivot)
in
if h<=pivot then (h::smalls,bigs)
else (smalls,h::bigs)
end;

fun quicksort ([])=([])	
|quicksort ([a])=([a])
|quicksort ([a,b])=
	if a<=b then [a,b]
	else [b,a]
|quicksort list=
let val mid=median(hd(list),middle(list),last(list))
val(left,right)=partition(list,mid)
in quicksort left@quicksort right
end;
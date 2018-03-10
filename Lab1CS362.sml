fun makeLst n=
 if n=0 then []
 else makeLst(n-1)@[n];

fun removeMult(lst,n)=
if null lst then lst
else if(hd lst) mod n=0 then
removeMult((tl lst),n)
else
(hd lst)::removeMult((tl lst),n);

fun primes(n)=
if n<2 then []
else let
fun eratosthenes lst=
if null lst then lst
else
(hd lst)::eratosthenes(removeMult(lst,(hd lst)))
in eratosthenes(tl(makeLst(n)))
end;
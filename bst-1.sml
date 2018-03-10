(* left subtree, right subtree, key, value *)
datatype BST = Empty | Node of BST * BST * int * int;

fun parsePost [] = Empty
|   parsePost lst =
    let
        fun pP (stack, (0,k,v)::str) = pP(Node(Empty, Empty, k, v)::stack, str)
        |   pP (L::stack, (1,k,v)::str) = pP(Node(L, Empty, k, v)::stack, str)
        |   pP (R::stack, (2,k,v)::str) = pP(Node(Empty, R, k, v)::stack, str)
        |   pP (R::L::stack, (3,k,v)::str) = pP(Node(L, R, k, v)::stack, str)
        |   pP (T::stack, []) = T;
    in
        pP([],lst)
    end;

val exTree0 = []
val exTree1 = [(0,1,1),(0,3,3),(3,2,2)];
val exTree2 = [(0,2,2),(2,1,1),(0,4,4),(3,3,3),(0,6,6),(1,7,7),(3,5,5)];
val exTree3 = [(0,1,1),(0,4,4),(1,5,5),(3,2,2),(0,8,8),(0,15,15),(2,14,14),(3,11,11)];

fun insert (Empty,key,value)= Node(Empty,Empty,key,value)
| insert (Node (left, right,k,v),key, value) =
if key < k
then Node(insert (left,key,value),right,k,v)
else Node(left,insert (right,key,value),k,v);

fun find(Empty, key) = Empty
      | find (Node (l,r,k,v), key) =
        if key = k then
             Node(l,r,k,v)
        else if key < k then
            find (l, key)
        else
            find (r, key);
             
fun postOrder(Empty)=nil
|postOrder(Node(Empty,Empty,key,value))=[(0,key,value)]
|postOrder(Node(Left,Empty,key,value))=postOrder(Left)@[(1,key,value)]
|postOrder(Node(Empty,Right,key,value))=postOrder(Right)@[(2,key,value)]
|postOrder(Node(Left,Right,key,value))=postOrder(Left)@postOrder(Right)@[(3,key,value)];

fun delMin(Node(Empty,i,t2,v))=(i,t2)
|delMin(Node(t1,i,t2,v))=
let val(t1',m)=delMin t1
in
(Node(t1',i,t2,v),m)
end;

fun delete(Empty,key) = Empty
 |  delete(Node(left,right,k,v),key) =
      if key<k then Node(delete(left,key),right,k,v)
      else if k<key then Node(left,delete(right,key),k,v)
      else
        if left = Empty then right
        else if right = Empty then left
        else let val(R,z) = delMin(right)
             in Node(left,R,z,v)
             end;
             
fun subtree(Empty,minKey,maxKey)=Empty
|subtree(Node(Left,Right,k,v),minKey,maxKey)= 
if minKey<k andalso k<maxKey then Node(delete(Left,minKey),delete(Right,maxKey),k,v)
else if minKey<k then Node(delete(Left,minKey),Right,k,v)
else Node(Left,delete(Right,maxKey),k,v);

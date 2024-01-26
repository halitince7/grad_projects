//load "c:/users/mathatin/desktop/PerfectCode/perfect.txt";



q := 5;
Zq := IntegerRing(q);


function EltLee(w)
w := IntegerRing()!w;
if w le q/2 then
   return w;
else
   return q-w;
end if;
end function;



function VectLee(v)
sum := 0;
for i := 1 to 12 do
    sum := sum + EltLee(v[i]);
end for;

return sum;
end function;

function MinDist(V)
min := 100000;
top := #V;
top;
i := 0;
for v in V do
    we := VectLee(v);
    if we ne 0 and we lt min then
       min := we;
    end if;

i := i+1;

if i mod 1000000 eq 0 then
print "calculating... ";
s := i/top;
d := RealField()!s;
d;
end if;

end for;
return min;
end function;

/*
A := [ 0,0,1,1,1,1,1,2,2,2,2,2,
       1,2,0,1,2,3,4,0,1,2,3,4
      ];

M := Matrix(Zq,2,12,A); 
H := Transpose(M);
NS := NullSpace(H);

#NS;
MinDist(NS);
*/


MS := KMatrixSpace(GF(q), 2, 12);

A := [ 0,0,1,1,1,1,1,2,2,2,2,2,
       1,2,0,1,2,3,4,0,1,2,3,4
      ];

M := MS!Matrix(Zq,2,12,A);



#MS;


for Ma in MS do
if Ma eq M then
Ma;
break;
end if;
end for;








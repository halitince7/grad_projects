//load "c:/users/acer/desktop/diff_set.txt";

q := 4;
k:=3;
F := GF(q);
P<x> := PolynomialRing(F);

p := x^3 + 2*x^2 +1;


for p in AllIrreduciblePolynomials(F, k) do

printf "****************** \n ";
p;

F_ext<x> := ExtensionField< F, x | p >;
w := PrimitiveElement(F_ext);
D := [0];
for j in F do
    for i := 0 to q^k-1 do
        if w^i eq j+w then
           Append(~D,i mod (q^2+q+1) );
           break;
        end if;
    end for;
end for;

D;
printf "****************** \n ";

end for;


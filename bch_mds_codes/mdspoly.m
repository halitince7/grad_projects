//load "c:/users/mathatin/desktop/mdspoly.txt";
D  := "c:/users/mathatin/desktop/mdsssspolyson.txt";



F<w> := GF(16);
P<x> := PolynomialRing(F); 

q := 16;

for i0:= 0 to q do
for i1:= 0 to q do
for i2:= 0 to q do
for i3:= 0 to q do
for i4:= 0 to q do
for i5:= 0 to q do
for i6:= 0 to q do
for i7:= 0 to q do
f := F.1^i0 + F.1^i1*x + F.1^i2*x^2 + F.1^i3*x^3 + F.1^i4*x^4+
F.1^i5*x^5 + F.1^i6*x^6 + F.1^i7*x^7 + x^8;

Tv := Transpose(CompanionMatrix(f));

i := 0;
j := 0;
S := Factorization(f);

for p in S do

G :=Transpose( Evaluate(p[1], Tv ) );
C := LinearCode(G);
if IsMDS(C) then
d := MinimumDistance(C);
Rs1 := RootsInSplittingField(f);

Rs2 := RootsInSplittingField(f-x^8);
Write(D,d);
Write(D,"f=");
Write(D,f);
Write(D,"roots of f:");
Write(D,Rs1);
Write(D,"p=");
Write(D,p);
Write(D,"roots of v:");
Write(D,Rs2);
Write(D,"---------------------------------------------------");

i := i+1;
else
j := j+1;
end if;
end for;



end for; end for; end for; end for; end for; end for; end for; end for;
i;
j;

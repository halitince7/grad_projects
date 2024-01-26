//load "c:/users/mathatin/desktop/trace3.txt";

//Improved by Halit Ýnce

// &gt; MinimalPolynomial(a);

// $.1^6 + $.1^4 + $.1^3 + $.1 + 1

//Finite Field construction

p:=2;

n:=6;

//Eltseq(a^21, F);

F := GF(2);

R&lt;x&gt; := PolynomialRing(F);

P := x^4+x+1;

//IsIrreducible(P);

K&lt;a&gt;:=ext&lt; F | P &gt;;

//Calculations of Fourier transform

Fourier:= function(k,L)

return &amp;+[L[t]*(a^((t-1)*k)): t in [1..#L] ];

end function;

//All Fourier coefficients for a sequence L

//L:=[0,1,0,0,0,1,0,0,1,0,0,0,1,0,1,1,1,1,0,0,0];

//L := [0,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0];

//L:=[0,1,0,0,0,1,1,0,1,1,0,0,1,0,1,1,1,0,0,1,1];

L:=[1,1,1,0,1,1,0,0,0,1,0,1,0,0,1];

print &quot;the sequence is&quot;;L;

Fc:=[Fourier(k-1,L): k in [1..#L]];

print &quot;Fourier transform (first version)&quot;; Fc;

//Calculations of Inverse Fourier transform

InvFourier:= function(t,Fc)

return &amp;+[Fc[k]*(a^(-(k- 1)*t)): k in [1..#Fc] ];

end function;

//reconstruction of the sequence L

InvFc:=[InvFourier(t-1,Fc): t in [1..#Fc]];

L eq InvFc;

print &quot;Inverse of the DFT(first version) is&quot;;InvFc;

//construction of the cyclotomic coset whose coset leader is s

d:=Divisors(n);

CyclotomicCoset:= function(s)

for i in d do

if s*p^i mod #L eq s then

ns:=i;

break;

end if;

end for;

return {@s*p^(j-1) mod #L: j in [1..ns+1] @};

end function;

//CyclotomicCoset(5);

CosetLeaders := [];

D := [0..#L-1];

while #D ne 0 do

CC := CyclotomicCoset(D[1]);

Append(~CosetLeaders,D[1]);

//CC;

for c in CC do

Exclude(~D,c);

end for;

end while;

print &quot;Coset Leaders are&quot;;CosetLeaders;





Fourier2:= function(k,L)

return &amp;+[L[t]*(a^(-(t- 1)*k)): t in [1..#L] ];

end function;

function Tracee(x,n)

return &amp;+[ x^(2^(i-1)): i in [1..n] ];

end function;

Exclude(~CosetLeaders,0);

Fc2 := [];

for k in CosetLeaders do

Fc2[k] := Fourier2(k,L);

end for;

print &quot;Fourier transform (second version)&quot;;Fc2;

InvFourier2:= function(t,Fc2)

return &amp;+[Tracee(Fc2[k]*(a^(k*t)),#CyclotomicCoset(k)): k in CosetLeaders ];

end function;

//reconstruction of the sequence L

InvFc2:=[InvFourier2(t-1,Fc2): t in [1..#Fc]];

L eq InvFc2;

print &quot;Inverse of the DFT(second version) is&quot;;InvFc2;
//load "c:/users/mathatin/desktop/DFT2.txt";

L:=[1,1,1,0,1,1,0,0,0,1,0,1,0,0,1];

//Finite Field construction
p:=2;
n:=4;
P<x> := PolynomialRing(GF(p));
r := x^4+x+1;
K<b>:=ext< GF(p) | r >;


f:=(p^n-1)div(#L);
f:=IntegerRing() ! f;
a:=b^f;

N:=15;

d:=Divisors(n);

CyclotomicCoset:= function(s)
   for i in d do
       if s*p^i mod #L eq s then
          ns:=i;
          break;
       end if;
    end for;
    return  {@s*p^(j-1) mod #L: j in [1..ns+1] @};
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

print "Coset Leaders are";CosetLeaders;
  





 

Fourier:= function(k,L)
	return  &+[L[t]*(a^((t-1)*k)): t in [1..#L] ];
end function;

function Tracee(x,n) 
         return &+[ x^(2^(i-1)): i in [1..n] ]; 
end function;


Exclude(~CosetLeaders,0);
Fc := [];
for k in CosetLeaders do
       Fc[k] := Fourier(k,L);
end for;
Fc;



InvFourier:= function(t,Fc)
	return  &+[Tracee(Fc[k]*(a^(-k*t)),#CyclotomicCoset(k)): k in CosetLeaders ];
end function;

//reconstruction of the sequence L
InvFc:=[InvFourier(t-1,Fc): t in [1..#Fc]];

InvFc;
L eq InvFc;



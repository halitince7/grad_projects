//load "c:/users/mathatin/desktop/block.txt";

m := 3;
K<w> := GF(2^m);


F := [];
for x in K do
    if x ne 1 then 
    Append(~F,x);
    end if;
end for;
Append(~F,1);
F;

function f(x)
   res := x+x^2;
   return res;
end function;

D1 := [ ];
for x in K do
    Append(~D1,f(x));
end for;

D1s := SequenceToSet(D1);

Block := [ ];
for x in F do
    Temp := [ ];
    for d in D1s do
        Append(~Temp,d+x);
    end for;
    Append(~Block,Temp);
end for;

Block;


M := ZeroMatrix(K,2^m,2^m);
for i:=1 to 2^m do
    for j:=1 to 2^m do
        if F[i] in Block[j] then
           M[i][j] := 1;
        end if;
    end for;
end for;
M;     








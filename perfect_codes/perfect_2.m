//load "c:/users/mathatin/desktop/perfect.txt";

F := "c:/users/mathatin/desktop/RES_perfect.txt";





for p in [23,29,31,41] do  
    for l := 2 to 30 do [p,l];

S1 := [x : x in [1..10000] | x mod p eq 1 ];
for n in S1 do
    S2 := [x : x in [1..10000] | x mod l eq 0 ];
    for k in S2 do
        a := p^(l*n-k);
        b := 1 + (p^l-1)*n;
        if a eq b then if n gt k then printf "HEEEEEEEEEEEEEEEEEEEY"; end if;
           D := [];
           Append(~D,p); Append(~D,l); Append(~D,n); Append(~D,k);
           D;
           //Write(F,D);
        end if;
    end for;
end for; 


    end for;
end for; 




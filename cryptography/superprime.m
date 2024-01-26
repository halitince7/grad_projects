//load "c:/users/acer/desktop/superprime.txt";





function SuperPrime(n,r)
     degree:= n;
     Primes := [];        
     Primes[1] := [ p : p in {2..r} | IsPrime(p) ];
     if degree eq 0 then
        return Primes[1];
     else
        Primes[degree+1] := [];
        Primes[degree] := SuperPrime(degree-1,r);
        for i := 1 to #Primes[degree] do
            if i in Primes[degree] then
               Append(~Primes[degree+1],Primes[degree][i]);
            end if;
        end for;
        return Primes[degree+1];
     end if;
end function;

SuperPrime(1,100);
//[ 3, 5, 11, 17, 31, 41, 59, 67, 83 ]  
      
SuperPrime(2,1000);
//[ 11, 31, 127, 277, 709 ]

SuperPrime(3,100000);
//[ 5381, 52711 ]
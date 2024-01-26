//load "c:/users/acer/desktop/elliptic.txt";


EC1 := EllipticCurve([12, 30]);

//EC1;

//EllipticCurveFromjInvariant(j);

//Points(EC1,1);


for x := 1 to 1000 do
     if IsPoint(EC1,x) then
        IsPoint(EC1,x);
     end if;
end for;


E := EllipticCurve([1, 0, 0, 12948, 421776]);
P := E![ -65498304*1567, -872115836268, 1567^3 ];
//DivisionPoints(P, 3);


F := GF(13);
E := EllipticCurve([F!5, F!7]);
E;
P := Random(E);
Q := Random(E);
P;
Q;
P+Q;
Order(E);
//CryptographicCurve(F);
//RationalPoints(E);
//Generators(E);
//TorsionSubgroup(E);
Log(Q, P); // n*Q = P, -1 if no solution


//GetSeed(); // ???
K := GF(RandomPrime(40));
E := EllipticCurve([Random(K), Random(K)]);
E;
Q := Random(E);
Q;

FactoredOrder(Q);
/*
This function returns the factorization of the order 
of the group of K-rational points
of E, where E is an elliptic curve 
de¯ned over the ¯nite ¯eld K. This factorization
is stored on E, and is reused when 
computing the order of points on E.
*/

P := Random(Order(Q))*Q;
P;
m := Log(Q, P);
m;
m*Q - P;








//load "c:/users/mathatin/desktop/mds2.txt";
DR  := "c:/users/mathatin/desktop/poly_mds_sonuc2.txt";

function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;

Search := procedure(s,n)
    q := 2^s;
    F<w> := GF(q);
    P<x> := PolynomialRing(F); 
   
function PolyCyc(f,v,n)
  H := [ ];
  for i in [1..n] do
    Append(~H,Coeff(f,n));
    f := x*f mod (x^n - v) ;
  end for;
  C := LinearCode< F, n | H >;
  return C;
end function;

function PolyCyc2(f,v,n)
  g := x^n - v;
  Tv := CompanionMatrix(g);
  G := Evaluate(f, Tv ) ;
  C := LinearCode(G);
  return C;
end function;

 
count1 := 0;
count2 := 0;
count3 := 0; 
   for i0:= 0 to q do
        for i1:= 0 to q do
            for i2:= 0 to q do
                for i3:= 0 to q do
                    v := F.1^i0 + F.1^i1*x + F.1^i2*x^2 + F.1^i3*x^3 + x^4;
                    //d := Degree(v);
                    S := ScalarMatrix(F,4,1);
                    A := CompanionMatrix(v);
                    M := A^4;
                    B := HorizontalJoin(M,S);
                    C := LinearCode(B);
                    //C;
                    
                    if IsMDS(C) then
                       Write(DR, "gecerli v(x) den cikan mds ve non mds sayisi: ");
                       Write(DR, count2);
                       Write(DR, count3);
                       count2 := 0;
                       count3 := 0;
                       count1 := count1 + 1;
                       Write(DR, "-------------------------------------------------");
                       Write(DR, count1);
                       Write(DR, "gecerli v(x) and MDS code:");
                       Write(DR, v);
                       Write(DR, C);
                       S := Factorization(x^n-v);
                       for i:=1 to #S do
                           f := S[i,1];
                           C1 := PolyCyc(f,v,n);
                           C2 := PolyCyc2(f,v,n);
                           C1 eq C2;
                           if IsMDS(C1) then
                              count2 := count2 + 1;
                              Write(DR, " ");
                              Write(DR, "f(x) ve v(x):");
                              Write(DR,f);
                              Write(DR,v);
                              Write(DR,C1);
                              Write(DR,C2);
                              Write(DR, " ");
                           else
                              count3 := count3 + 1;
                           end if;
                        end for;
                    end if;
                 end for;
             end for;
         end for;
     end for;
end procedure;

Search(6,10);





8741
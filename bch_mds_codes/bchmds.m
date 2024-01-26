//load "c:/users/mathatin/desktop/mustafa/bchmds.txt";
YAZ  := "c:/users/mathatin/desktop/mmmmmm.txt";

BCH := function(k,s)
   q := 2^s;
   F := GF(q);
   P<x> := PolynomialRing(F);
   S := { };
   for z:=1 to q+1-2*k by 2 do
      a := RootOfUnity(2*k+z, F);
      Pext<X> := PolynomialRing(Parent(a));
      for i:=0 to 2*k+z-1 do
        b := a^i;
        if Order(b) eq (2*k+z) then
          g := &*[(X-b^l): l in [-1..k-2]];
          for l in [0..2*k+z-2] do
            g := (g*(X-b^(l+k-1))) div (X-b^(l-1));
            if IsCoercible(P,g) then
              Include(~S, P!g);
            end if;
          end for;
        end if;
      end for;
   end for;
   return S;
end function;


k:=24;
s:=24;
q := 2^s;
F<w> := GF(q);
P<x> := PolynomialRing(F);
S := BCH(k,s);

#S;




function PolyCyclic(f,v,n)
  Tv := CompanionMatrix(v);
  G :=  Evaluate(f, Tv );
  C := LinearCode(G);
  return C;
end function;


s1 := 0;
s2 := 0;

for f in S do 

   n := Degree(f);
   v := f;
   Pol := Factorization(v);

  
   for i in [1..#Pol] do
      g := Pol[i,1];
      C := PolyCyclic(g,v,n); 
      if IsMDS(C) then 
         s1 := s1+1;
      else 
         s2 := s2+1; 
      end if;
   end for;

end for;

s1;
s2;

















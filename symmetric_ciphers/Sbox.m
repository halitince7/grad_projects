//load "c:/users/mathatin/desktop/Sbox.txt";

function Binary(x)
         S := [];
         i := 0;
         while i le 3 do 
               Append(~S,(x mod 2));
               x := x div 2;
               i := i+1;
         end while;
         Reverse(~S);
         return S;
end function;



Sbox := [14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7];


Diff := ZeroMatrix(IntegerRing(),16,16); 
for i := 1 to 16 do
    for j := 1 to 16 do
        counter := 0;
        for k := 0 to 15 do
            if BitwiseXor( Sbox[BitwiseXor(i-1,k)+1] , Sbox[k+1] ) eq j-1 then
               counter := counter+1;
            end if;
         end for;
         Diff[i][j] := counter;
     end for;
end for;
Diff;

print " ";

LAT := ZeroMatrix(IntegerRing(),16,16); 
for i := 1 to 16 do
    for j := 1 to 16 do
        D1 := Binary(i-1);    
        D2 := Binary(j-1);  
        Non_zeroD1 := [];
        Non_zeroD2 := [];
        for a := 1 to  #D1 do
            if D1[a] eq 1 then Append(~Non_zeroD1,a); end if;
        end for;
        for a := 1 to  #D2 do
            if D2[a] eq 1 then Append(~Non_zeroD2,a); end if;
        end for;
        
        counter := 0;
        for x := 0 to 15 do
            v := Binary(x); 
            Sv:= Binary(Sbox[x+1]);
            if #Non_zeroD1 eq 0 then
               Sum_v := 0;
            else
                Sum_v  := &+[ v[i] : i in Non_zeroD1 ] mod 2;
            end if;
            if #Non_zeroD2 eq 0 then
               Sum_Sv := 0;
            else
                Sum_Sv  := &+[ Sv[i] : i in Non_zeroD2 ] mod 2;
            end if;        
            if Sum_v eq Sum_Sv then counter := counter+1; end if;
        end for;
        LAT[i][j] := counter-8;

     end for;
end for;
LAT;

























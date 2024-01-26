//load "c:/users/mathatin/desktop/LBlockSbox.txt";




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



function DDT(Sbox)

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

return Diff;

end function;



function LAT(Sbox)

Lat := ZeroMatrix(IntegerRing(),16,16); 
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
        Lat[i][j] := counter-8;

     end for;
end for;

return Lat;


end function;



s0 := [14, 9, 15, 0, 13, 4, 10, 11, 1, 2, 8, 3, 7, 6, 12, 5]; 
s1 := [4, 11, 14, 9, 15, 13, 0, 10, 7, 12, 5, 6, 2, 8, 1, 3];
s2 := [1, 14, 7, 12, 15, 13, 0, 6, 11, 5, 9, 3, 2, 4, 8, 10];
s3 := [7, 6, 8, 11, 0, 15, 3, 14, 9, 10, 12, 13, 5, 2, 4, 1];
s4 := [14, 5, 15, 0, 7, 2, 12, 13, 1, 8, 4, 9, 11, 10, 6, 3];
s5 := [2, 13, 11, 12, 15, 14, 0, 9, 7, 10, 6, 3, 1, 8, 4, 5];
s6 := [11, 9, 4, 14, 0, 15, 10, 13, 6, 12, 5, 7, 3, 8, 1, 2];
s7 := [13, 10, 15, 0, 14, 4, 9, 11, 2, 1, 8, 3, 7, 5, 12, 6];
s8 := [8, 7, 14, 5, 15, 13, 0, 6, 11, 12, 9, 10, 2, 4, 1, 3];
s9 := [11, 5, 15, 0, 7, 2, 9, 13, 4, 8, 1, 12, 14, 10, 3, 6];

Sboxes := [s0,s1,s2,s3,s4,s5,s6,s7,s8,s9];


for s in Sboxes do

DDT(s); 
print " ";

end for;


for s in Sboxes do

LAT(s); 
print " ";

end for;

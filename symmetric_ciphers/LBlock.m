//load "c:/users/mathatin/desktop/LBlock.txt";


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

function Binary5(x)
         S := [];
         i := 0;
         while i le 4 do 
               Append(~S,(x mod 2));
               x := x div 2;
               i := i+1;
         end while;
         Reverse(~S);
         return S;
end function;

function DivideBy4(L)
         B := [];
         temp := [];
         for i := 1 to 32 do
             Append(~temp,L[i]);
             if i mod 4 eq 0 then
                Append(~B,temp);
                temp := [];
             end if;
          end for;
          return B;
end function;

function LeftShift(L1,k)
         L:=[];
         for i := 0 to #L1-1 do
             L[i+1] := L1[((i+k) mod #L1)+1];
         end for;
         return L;
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

Sbox := [s0,s1,s2,s3,s4,s5,s6,s7,s8,s9];

function Confussion(R)
         Rn := DivideBy4(R);
         Res := [];
         for i := 0 to 7 do
             input := Seqint(Reverse(Rn[i+1]),2);
             Append(~Res,Binary(Sbox[8-i][input+1]));
         end for;
         return Res;
end function;
  
function Diffussion(R)
         Res := [];
         Res[1] := R[2];
         Res[2] := R[4];
         Res[3] := R[1];
         Res[4] := R[3];
         Res[5] := R[6];
         Res[6] := R[8];
         Res[7] := R[5];
         Res[8] := R[7];
         return Res;
end function;
                        





function Get(R)
         Rn := [];
         for i := 1 to 8 do
             Rn := Rn cat R[i];
         end for;
         return Rn;
end function;


function Subkeys(Key)
         Sub := [];
         for i := 1 to 32 do
             temp := [];
             for j := 1 to 32 do
                 Append(~temp,Key[j]);
             end for;
             Append(~Sub,temp);
             Key := LeftShift(Key,29);
             
             temp := [Key[1],Key[2],Key[3],Key[4]];
             input := Seqint(Reverse(temp),2);
             output := Binary(Sbox[10][input+1]);          
             Key[1] := output[1];
             Key[2] := output[2];
             Key[3] := output[3];
             Key[4] := output[4];

             temp := [Key[5],Key[6],Key[7],Key[8]];
             input := Seqint(Reverse(temp),2);
             output := Binary(Sbox[9][input+1]);          
             Key[5] := output[1];
             Key[6] := output[2];
             Key[7] := output[3];
             Key[8] := output[4];
         
             temp := [Key[30],Key[31],Key[32],Key[33],Key[34]];            
             bin := Binary5(i);
             Key[30] := (Key[30] + bin[1]) mod 2;
             Key[31] := (Key[31] + bin[2]) mod 2;
             Key[32] := (Key[32] + bin[3]) mod 2;
             Key[33] := (Key[33] + bin[4]) mod 2;
             Key[34] := (Key[34] + bin[5]) mod 2;
         end for;
        return Sub;
end function;





function EncryptionRound(L,K,R)
         R := LeftShift(R,8);
         for i := 1 to 32 do
             L[i] := (L[i]+K[i]) mod 2;
         end for;
         L := Confussion(L);
         L := Diffussion(L);
         L := Get(L);
         for i := 1 to 32 do
             R[i] := (R[i]+L[i]) mod 2;
         end for;
         return R;
end function;




X:=[];

X[2] := [
0,0,0,0,
0,0,0,1,
0,0,1,0,
0,0,1,1,
0,1,0,0,
0,1,0,1,
0,1,1,0,
0,1,1,1];

X[1]:= [
1,0,0,0,
1,0,0,1,
1,0,1,0,
1,0,1,1,
1,1,0,0,
1,1,0,1,
1,1,1,0,
1,1,1,1];



Key := [
0,0,0,0,
0,0,0,1,
0,0,1,0,
0,0,1,1,
0,1,0,0,
0,1,0,1,
0,1,1,0,
0,1,1,1,
1,0,0,0,
1,0,0,1,
1,0,1,0,
1,0,1,1,
1,1,0,0,
1,1,0,1,
1,1,1,0,
1,1,1,1,
1,1,1,1,
1,1,1,0,
1,1,0,1,
1,1,0,0];




X[2] := [
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0];

X[1] := X[2];

Key := [
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0]; 




K := Subkeys(Key);


for i := 3 to 34 do
    X[i] := EncryptionRound(X[i-1],K[i-2],X[i-2]);
end for;






for i := 1 to 8 do 
Seqint(Reverse(DivideBy4(X[33])[i]),2):Hex;
end for;
printf "\n";
for i := 1 to 8 do 
Seqint(Reverse(DivideBy4(X[34])[i]),2):Hex;
end for;


















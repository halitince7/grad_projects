//load "c:/users/acer/desktop/simple_cipher.txt";

Sbox := [14, 9, 15, 13, 0, 4, 10, 11, 1, 2, 8, 3, 7, 6, 12, 5]; 

function RoundKey(key,r)
       //return [4 mod 16, 1 mod 16];
         return [key[2*r],key[2*r-1]];
end function;

function KeyAdd(input,key,r)
         output := [0,0];
         rk := RoundKey(key,r);
         for i := 1 to 2 do
             output[i] := BitwiseXor(input[i],rk[i]);
         end for;
         return output;
end function;

function SBox(input)
         return [Sbox[input[1]+1],Sbox[input[2]+1]];
end function;

function Perm(input)
         return [input[2],input[1]];
end function;


function F(input,key,r)
         return Perm(SBox(KeyAdd(input,key,r)));
end function;

function Xor(d1,d2)
         res := [];
         for i := 1 to #d1 do
             Append(~res,BitwiseXor(d1[i],d2[i]));
         end for;
         return res;
end function;


function Encrypt(plaintext,key,round)
         pt_L := [plaintext[i] : i in [1,2]];
         pt_R := [plaintext[i] : i in [3,4]];
         for r := 1 to round do
             temp := pt_R;
             pt_R := pt_L;
             pt_L := Xor(temp,F(pt_L,key,r));
         end for; 
         return pt_L cat pt_R;
end function;

function Decrypt(ciphertext,key,from_round,to_round)
         ct_L := [ciphertext[i] : i in [1,2]];
         ct_R := [ciphertext[i] : i in [3,4]];
         while from_round gt to_round do
             temp := ct_L;
             ct_L := ct_R;
             ct_R := Xor(temp,F(ct_R,key,from_round-1));
             from_round := from_round - 1;
         end while; 
         return ct_L cat ct_R;
end function;



//plaintext := [ 10,8,3,4 ];
//key := [1,2,3,4,5,6,7,8,9,10,11,12];
//Encrypt(plaintext,key,1);
//Decrypt(plaintext,key,7,4);    











key := [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
Int := [];
counter1 := [0,0,0,0];


c1 := Random({0..15});
c2 := Random({0..15});
c3 := Random({0..15});


for a1 in [0..15] do
    plaintext := [c1, c2, c3, a1];
 ciphertext1 := Encrypt(plaintext,key,6); 
    Append(~Int,ciphertext1);
    counter1 := [BitwiseXor(counter1[1],ciphertext1[1]),
                BitwiseXor(counter1[2],ciphertext1[2]),
                BitwiseXor(counter1[3],ciphertext1[3]),
                BitwiseXor(counter1[4],ciphertext1[4])];
end for;



procedure Analiz(Int,counter)
          sets := [];
          for i:= 1 to 4 do
              set := {};
              for j := 1 to 16 do
                  Include(~set,Int[j][i]);
              end for;
              Append(~sets,set);
          end for;
          for i := 1 to 4 do
              if    #sets[i] eq 16 then printf "A";
              elif  #sets[i] eq 1 then printf "C";              
              elif  counter[i] eq 0 then printf "B";
              else printf "?";
              end if;
          end for;
end procedure;


//Analiz(Int,counter1);
//printf "\n"; printf "\n";



 
//Int;


//normal key recovery
for tahmin1,tahmin2 in [0..15] do

    sum := 0;
    for seq in Int do
        a1 := seq[1];
        b0 := seq[4];
        temp :=
        BitwiseXor(
        Sbox[
              BitwiseXor(   BitwiseXor(
                                        Sbox[BitwiseXor(b0,tahmin2)+1],
                                        a1),
                          tahmin1)   
            +1],
         b0);
        sum := BitwiseXor(sum,temp);

    end for;

    if sum eq 0 then 
       [tahmin1, tahmin2];
    end if;

end for;
a;

printf "\n";






// MIMT ile key recovery:

for tahmin1,tahmin2 in [0..15] do


    sum := 0;
    sum2 := 0;

    for seq in Int do
        a0 := seq[1];
        a1 := seq[4];
        temp :=
        Sbox[
                BitwiseXor(BitwiseXor(a0,tahmin1), Sbox[BitwiseXor(a1,tahmin2)+1])
        +1];
              
        sum := BitwiseXor(sum,temp);
        sum2 := BitwiseXor(sum2,a1);
    end for;


    if sum eq sum2 then 
       [tahmin1, tahmin2];
    end if;


end for;

1;


            
// partial sum ile key recovery:


for tahmin2 in [0..15] do
    sum := 0;
    sum2 := 0;
    Int2 := {};
    for seq in Int do
        a0 := seq[1];
        a1 := seq[4]; sum2 := BitwiseXor(sum2,a1);
        y1 := BitwiseXor(Sbox[BitwiseXor(a1,tahmin2)+1],a0);
        Include(~Int2,y1);
        for tahmin1 in [0..15] do 
            for y1 in Int2 do
            temp := Sbox[BitwiseXor(y1,tahmin1)+1];
            sum := BitwiseXor(sum,temp);
         

                if sum eq sum2 then 
                   [tahmin1, tahmin2];
                end if;
            end for;
         end for;
     end for;
end for;



3;








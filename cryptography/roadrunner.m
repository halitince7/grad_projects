//load "c:/users/acer/desktop/roadrunner.txt";

Sbox := [0,8,6,13,5,15,7,12,4,14,2,3,9,1,11,10];

perm1 := 
[1,5,09,13,17,21,25,29,
 2,6,10,14,18,22,26,30,
 3,7,11,15,19,23,27,31,
 4,8,12,16,20,24,28,32];

perm2 := 
[1,09,17,25,
 2,10,18,26,
 3,11,19,27,
 4,12,20,28,
 5,13,21,29,
 6,14,22,30,
 7,15,23,31,
 8,16,24,32]; 


input := [0,0,0,1, 0,0,1,1, 0,0,0,0, 1,0,0,0, 0,0,1,1, 0,0,1,0, 1,1,1,1, 0,1,1,1];

function Binary4(x)
         seq := Intseq(x,2);
         while #seq ne 4 do
               Append(~seq,0);
         end while;
         return Reverse(seq);
end function;

function Binary32(x)
         seq := Intseq(x,2);
         while #seq ne 32 do
               Append(~seq,0);
         end while;
         return Reverse(seq);
end function;

function BinSeq(seq)
         output := [];
         for elt in seq do
             output := output cat Binary4(elt);
         end for;
         return output;
end function;
               
function SBox(input)
         output := [];
         temp := [];
         for i := 1 to 32 do
             Append(~temp,input[i]);
             if i mod 4 eq 0 then
                Append(~output,Sbox[Seqint(Reverse(temp),2)+1]);
                temp := [];
             end if;
         end for;
         return BinSeq(output);
end function;

    


function LeftShift(L1,k)
         L:=[];
         for i := 0 to #L1-1 do
             L[i+1] := L1[((i+k) mod #L1)+1];
         end for;
         return L;
end function; 

function DivideBy(L,n)
         B := [];
         temp := [];
         for i := 1 to #L do
             Append(~temp,L[i]);
             if i mod n eq 0 then
                Append(~B,temp);
                temp := [];
             end if;
          end for;
          return B;
end function;

function Read(input)
    output := [];
    for seq in DivideBy(input,4) do
        Append(~output,Seqint(Reverse(seq),2));
    end for;
    return output;
end function;

function Sumseq(s1,s2,s3)
         output := [];
         for i := 1 to #s1 do
             output[i] := (s1[i]+s2[i]+s3[i]) mod 2;
         end for;
         return output;
end function;

function SumSeq(s1,s2)
         output := [];
         for i := 1 to #s1 do
             output[i] := (s1[i]+s2[i]) mod 2;
         end for;
         return output;
end function;


function Llayer(input)
         temp := DivideBy(input,8);
         output := [];
         for seq in temp do
             output := output cat Sumseq(seq,LeftShift(seq,1),LeftShift(seq,2));
         end for;
         return output;
end function;


function SLK(input)
         temp:=[];
         for i := 1 to #input do
             temp[perm1[i]] := input[i];
         end for;
         
         input2 := SBox(temp);
         temp:=[];
         for i := 1 to #input2 do
             temp[perm2[i]] := input2[i];
         end for;   
         
         output := Llayer(temp);
         return output;
end function;

function F(input,NR)
         output := input;
         output := SLK(output); 
         output := SLK(output); 
         output := SumSeq(output,Binary32(10-NR)); 
         output := SLK(output);
         temp:=[];
         for i := 1 to #output do
             temp[perm1[i]] := output[i];
         end for;          
         output := SBox(temp);
         temp:=[];
         for i := 1 to #output do
             temp[perm2[i]] := output[i];
         end for;          
         return temp;
end function;



function Round(input,NR)
         output := [];
         temp := DivideBy(input,32);
         output := SumSeq(temp[2],F(temp[1],NR)) cat temp[1];
         return output;
end function;
   







input := [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0];
input := BinSeq(input);
for i := 0 to 9 do
    input :=Round(input,i);
end for;

Read(input):Hex;

/*
counter := [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0];
for a in [0..15] do
    input := [4,0,0,0, 0,0,0,0, a,0,0,0, 0,0,0,0];
    input := BinSeq(input);
    for i := 0 to 3 do 
        input :=Round(input,i);
    end for;
    counter := SumSeq(counter,input);
end for;
print " ";
counter; 
*/

counter := [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0];
for a1,a2,a3,a4,a5,a6,a7,a8 in [0..15] do
    input := [0,0,0,0, 0,0,0,0, a1,a2,a3,a4,a5,a6,a7,a8];
    input := BinSeq(input);
    for i := 0 to 3 do 
        input :=Round(input,i);
    end for;
    counter := SumSeq(counter,input);
end for;
print " ";
counter; 





         
             




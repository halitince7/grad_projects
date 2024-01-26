//load "c:/users/acer/desktop/poly_Fq.txt";


R := IntegerRing();

B := [[1,2,4],[2,3,5],[3,4,6],[0,4,5],[1,5,6],[0,2,6],[0,1,3]];
A := [[3,5,6],[0,4,6],[0,1,5],[1,2,6],[0,2,3],[1,3,4],[2,4,5]];


J := ZeroMatrix(R,21,21);
for i:=1 to 21 do
    for j:=1 to 21 do
        J[i][j] := 1;
    end for;
end for;


Rows := [];
for j := 1 to 7 do
    dizi := [];
    for i := 1 to 7 do
        intersection := Seqset(B[j]) meet Seqset(A[i]);               
        for k := 1 to 3 do
            if A[i][k] in intersection then
               Append(~dizi,1);
            else
               Append(~dizi,0);
            end if;
        end for;
    end for;
    for n := 1 to 3 do
        Append(~Rows,dizi);
    end for;
end for;

P := Transpose(Matrix(Rows));
Pt := Transpose(P);

P*Pt*P;

P*Pt*P eq 18*P+27*J;



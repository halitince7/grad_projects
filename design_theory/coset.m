//load "c:/users/acer/desktop/coset.txt";

F := GF(2);
n := 4;
L := [[0,0,0,0],[1,0,1,1],[0,1,0,1],[1,1,1,0]];
C := LinearCode< F, n | L >;
D := CosetLeaders(C);


for i := 1 to #D do         
    for c in C do
        printf "%o ",c+D[i];
    end for;
    printf "\n";
end for;
                  
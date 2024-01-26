//load "c:/users/acer/desktop/quaternion.txt";

K<w> := GF(4);
A<i,j,k> := QuaternionAlgebra< K | -1, -1 >;

S := {};
for a1,a2,a3,a4 in K do
    Include(~S,a1+a2*(1+i)+a3*(1+j)+a4*(1+k));
end for;

function Format(s)
         for a,b,c,d in K do
             if s eq a+b*(1+i)+c*(1+j)+d*(1+k) then
                return [a,b,c,d];
             end if;
         end for;
end function;

function Gray(s)
         f := Format(s);
         a:=f[1];
         b:=f[2];
         c:=f[3];
         d:=f[4];
         return [b,c,d,a+b+c+d];
end function;

s := 1+(1+i)*w+(1+k)*w^2;
Gray(s);

r1 := [1,w*(i+j+k),w^2*i,w*(i+k)];
r2 := [i+k,w*(i+j+k),i,w^2];

D := {};
for a,b in S do
    Include(~D,Gray(a*1+b*(i+k)) cat Gray(a*w*(i+j+k)+b*w*(i+j+k)) cat Gray(a*w^2*i+b*i) cat  Gray(a*w*(i+k)+b*w^2));
end for;

LinearCode< K, 16 | G >;






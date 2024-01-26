//load "c:/users/acer/desktop/elgamal.txt";


//El Gamal Encryption System


function IsGen(g,p)
         i := 1;
         h := g^i mod p;
         while h ne 1 do
               i := i + 1;
               h := g^i mod p;
         end while;
         if i eq p-1 then
            return true;
         else 
            return false;
         end if;
end function;
         
function inverse(g,p)
         for i := 1 to p-1 do
             if g*i mod p eq 1 then
                return i;
                break;
             end if;
         end for;
end function;









print " ";
print " ";


printf "\n \n *************************************************";
printf "\n \n ************ EL GAMAL ENCRYPTION ****************";
printf "\n \n *************************************************";

print " ";
print " ";

menu := 0;

while menu eq 0 do
      print " \n   \n \n              *** MENU *** \n " ;

      printf "  1) Key Generator \n ";
      printf " 2) Encrypt a message \n";
      printf "  3) Decrypt a message \n ";
      print " ";
      readi sec;

      if sec eq 1 then 
         // Set up of Alice
         Set := {1255..6455};
         n := Random(Set);
         p := NextPrime(n);
         g := 2;
         while not IsGen(g,p) do
               g := g + 1;
         end while;
         k := Random({1..p-1});
         h := g^k mod p;
         // Alice public key = p,g,h    private key = k
         print " ";
         printf "      Public key: \n
         p = %o 
         g = %o 
         h = %o  \n
        Private key: \n
        k = %o \n ", p,g,h,k  ;
        printf " \n Back to Menu: 0 \n Exit: 1";
        readi menu;

      elif sec eq 2 then
        printf "please write the public key: \n";
        print "   p = ";
        readi p;
        print "   g = ";
        readi g;
        print "   h = ";
        readi h;
        printf "please write message: ";
        readi m;
        //Bob Encryption of message m:
        //m_send := Random({1..p-1});
        y := Random({0..p-1});
        c1 := g^y mod p;
        s := h^y mod p;
        c2 := m*s mod p;
        //Bob Sends (c1,c2) to Alice
        printf "message encryted as (%o,%o) \n" ,c1,c2 ;
        printf " \n Back to Menu: 0 \n Exit: 1";
        readi menu;

      elif sec eq 3 then
        printf "please write the public key: \n";
        print "   p = ";
        readi p;
        print "   g = ";
        readi g;
        print "   h = ";
        readi h;
        printf "please write the private key: \n";
        readi k;
        printf "please write encrypted message: \n";
        print "\n c1 = ";
        readi c1;
        print "\n c2 =";
        readi c2;
        //Alice Decrytion:
        s := c1^k mod p;
        m_rec := c2*inverse(s,p) mod p; 
        printf " decrypted message: %o \n" , m_rec;
        printf " \n Back to Menu: 0 \n Exit: 1";
        readi menu;
      end if;
end while;




    
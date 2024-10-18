# // Example program
#  #include <iostream>
#  #include <string>
#  
#  
#  
#  int fib_n2=0, fib_n=0, fib_n1 = 1;
#  int n = 13;
#  
#  void fib() {
#  if(n==0) return;	
#    fib_n2 = fib_n + fib_n1;
#    fib_n = fib_n1;
#    fib_n1 = fib_n2;
#    n=n-1;
#    return fib();
#   }
#  
#  
#  
#  int main()
#  {
#     fib();
#    std::cout << "Hello, " << fib_n << "!\n";
#  }

#labs q's
#data is used to add in global values into the program
#word is a 32 bit comma seperated "variable"
#.text is the code section of the program


.data
.word 2, 4, 6, 8
n: .word 13

.text
main:   add     t0, x0, x0 # Set t0 to 0 the 0th fibonacci
        addi    t1, x0, 1  # Set t1 to 1 the 1st fibonacci
        la      t3, n # Load the address of n in t3
        lw      t3, 0(t3) # n = 13
		# Start the fibonacci function
# t0 : n-1th fibonacci (fib_n1) , t1 : n-2nd fibonacci number (fib_n2), t2 contains : nth fibonacci number (fib_n)
fib:    beq     t3, x0, finish # if n==0 return fib_n
        add     t2, t1, t0 
        mv      t0, t1     # fib_n1 = fib_n2
        mv      t1, t2     # fib_n2 = fib_n
        addi    t3, t3, -1 # n = n - 1
        j       fib # return fib()

finish: addi    a0, x0, 1
        addi    a1, t0, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall

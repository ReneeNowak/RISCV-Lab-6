.data
test_input: .word 3 6 7 8

.text
main:
	add t0, x0, x0 				#t0 = 0
	addi t1, x0, 4				#t1 = 4
	la t2, test_input			#t2 = &testinput
    
main_loop:
	beq t0, t1, main_exit  		#t0 != t1 so go to main_exit
	slli t3, t0, 2				# turn loop counter (t0) into adress jumps
	add t4, t2, t3				# add address number and loop counter
	lw a0, 0(t4)				# load value

	addi sp, sp, -20			# make space for 5 variables
	sw t0, 0(sp)
	sw t1, 4(sp)				# save values of t0 -> t4
	sw t2, 8(sp)
	sw t3, 12(sp)
	sw t4, 16(sp)

	jal ra, factorial			# go to factorial - save ra

	lw t0, 0(sp)				# return values of t0 -> t4
	lw t1, 4(sp)
	lw t2, 8(sp)
	lw t3, 12(sp)
	lw t4, 16(sp)
	addi sp, sp, 20				# 

	addi a1, a0, 0
	addi a0, x0, 1
	ecall # Print Result
	addi a1, x0, ' '
	addi a0, x0, 11
	ecall
	
	addi t0, t0, 1
	jal x0, main_loop
    
main_exit:  
	addi a0, x0, 10			#print, then exit
	ecall # Exit

factorial: #Inefficent? you betcha
    beq a0, x0, factorialExit #if a0 == 0 - exit
    add t1, x0, a0    #t1 == a0
    addi t1, t1, -1   #t1 == a0 - 1
    addi t4, x0, 1 #set up loop exit
fac:
	beq t1, t4, factorialExit
    mul a0, a0, t1  #put value of current number * current total into a0 (func arg)
	addi t1, t1, -1 #reduce curent factorial by 1
    jal x0, fac
    
factorialExit:
    jr ra
	

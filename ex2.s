.data
source:
	.word	3
	.word	1
	.word	4
	.word	1
	.word	5
	.word	9
	.word	0
dest:
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0

.text
main:
	addi t0, x0, 0 #t0 = 0
	la t1, source  #load address of source
	la t2, dest    # la of dest
    
loop:
	slli t3, t0, 2    # shift left twice (1 => 4, 2 => 8, 3 => 12, etc)
	add t4, t1, t3    # t4 = address of source + bit add
	lw t5, 0(t4)      # load value of source
	beq t5, x0, exit  # if t5 == 0 - exit
	add t6, t2, t3	  # add t2 (dest) and left shifted t3 (ajusted 32 bits)
	sw t5, 0(t6)      # save address of dest + adjustment
	addi t0, t0, 1	  # add 1 to address modifier (1, 2, 3, 4, 5, etc)
	jal x0, loop	  # jump to loop + 0
    
exit:
	jal ra, print_lists #go to Print_lists - come back to line 40 after
	addi a0, x0, 10
	add a1, x0, x0
	ecall # Terminate ecall

# For this part of the lab, you don't need to understand anything
# below this line.
print_lists:
	# Save the ra in the stack since it will be overwritten
	addi sp, sp, -4 #
	sw ra, 0(sp) #save previous line address - addi

	# Pass source array address to print_list
	la a0, source        #load source - put in a0 (func argument)
	jal ra, print_list	 #go to printlist, - come back here after

	# Print a newline
	addi a1, x0, '\n'
	addi a0, x0, 11
	ecall

	# Pass dest array address to print_list
	la a0, dest 		# load dest
	jal ra, print_list

	# Get back saved return address from stack and go to it
	lw ra, 0(sp)
	addi sp, sp, 4
	jr ra
    
print_list:
	# Stop recursing when the value at 0(a0) is 0
	lw t0, 0(a0)   					#load array element
	bne t0, x0, printMeAndRecurse	#if array[] != 0 go to printMeAndRecurse
	jr ra							# go back to ra
printMeAndRecurse:
	# Print integer pointed to by address in a0
	add t0, a0, x0                  # put array address in t0
	lw a1, 0(t0)					# load value in array[]
	addi a0, x0, 1					# a0 = 1
	ecall							# print

	# Print a space
	addi a1, x0, ' '				#a1 = ' '
	addi a0, x0, 11					# a0 = 11
	ecall							#print 

	# Go to next array element
	addi a0, t0, 4                 #increment array address by 4 and save in a0
	jal x0, print_list			   # go to print_list

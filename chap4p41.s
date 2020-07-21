	#PURPOSE: Program to illustrate how functions work
	#	This program will compute the value of
	#	2^3 + 5^2

	# Everything in the main program is stored in registers,
	# so the data section doesn't have anything
	.section  .data

	.section .text
	.globl _start
_start:
        #pushq %rbp

	pushl $3 # Push second argument
	pushl $3 # pushl first argument
	call power # call the function
	addl $8, %esp # move the stack pointer back

	pushl %eax

	pushl $2 # Push second argument 
	pushl $4 # push first argument
	call power # call function
	addl $8, %esp # move the stack poiunter back

	popl %ebx #The second answer is already
	          #in %eax. We saved the first answer onto the stack,
	          #so now we can just pop it out into %ebx
        #addl %eax, %eax
	subl %eax, %ebx # add them together
	                # result in %ebx
        pushl %ebx
        #pushl  %eax
#	movl (%esp), %ebx

        pushl $2 # Push second argument 
        pushl $4 # push first argument
        call power # call function
        addl $8, %esp # move the stack poiunter back

        popl %ebx #The second answer is already
                  #in %eax. We saved the first answer onto the stack,
                  #so now we can just pop it out into %ebx
        #addl %eax, %eax
        addl %eax, %ebx # add them together

	
	movl $1, %eax #exit (%ebx is returned)
	int $0x80 
	
	#PURPOSE: This function is used to compute the value of a number raised to a power.
	#INPUT:   First argument - the base number
	#	  Second argument - the power to raise it to
	#
	#
	#INPUT: First argunment - the base number
	#Second argument - the power to raise it to]#
	#
	#
	#OUTPUT: Will give the result as a returnj value
	#
	#NOTES: The power mustr be 1 or greater
	#
	#VARIABLES:
	#	%ebx - holds the base number
	#	%ecx - holds the power
	#	-4(%ebp) - holds the current result
	#
	#	%eax is used for temporary storage
	#
	.type power, @function
power:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
	movl %ebx, -4(%ebp)

power_loop_start:
	cmpl $1, %ecx
	je end_power
	movl -4(%ebp), %eax
	imul %ebx, %eax
	movl %eax, -4(%ebp)
	decl %ecx
	jmp power_loop_start
end_power:
	movl -4(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
	

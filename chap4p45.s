#PURPOSE - Given a number, this program computes the factorial. For example, the factorial of 3 is 3*2*1, or 6. The factorial of 4 is 4*3*2*1, or 24, and so on.
#This program shows how to call a function by first pushing all the arguments, then you call the function, and the resulting value is in %eax. The program can also change the passed parameters if it wants to.
.section .data
#This program has no global data
.section .text

.globl _start
.globl factorial # unneeded unless we wnat to share this function among other programs
_start:
pushl $4         #The favtorial  takes one argument - the number we want a factorial of. So, it gets pushed 
call factorial   #run the factorial function 
popl %ebx        # always remember to pop anything you pushed 
movl %eax, %ebx  #factorial returns the answer in %eax, but we want it in %eax to send it as our exit status
movl $1, %eax    #call the kernel's exit function
int $0x80

.type factorial, @function
factorial:
pushl %ebp  #standard function stuff - we have to restore 
            #ebp to its prior state before re4turning,
	    #so we have to push it

movl %esp, %ebp #This is because we don't want to modify 
                # the stack pointer, so we use %ebp instead. This is also because %ebp is more flexible

movl 8(%ebp), %eax

cmpl $1, %eax

je end_factorial
decl %eax
pushl %eax
call factorial 
popl %ebx

incl %ebx
imul %ebx, %eax

end_factorial:
movl %ebp, %esp
popl %ebp

ret


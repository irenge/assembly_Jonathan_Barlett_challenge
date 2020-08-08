.section .data
#This program has no global data
.section .text

.globl _start

.globl square 
_start:
pushl $5  
call square    
popl %ebx      
movl %eax, %ebx 
movl $1, %eax   
int $0x80

.type square, @function
square:
pushl %ebp
movl %esp, %ebp 

movl 8(%ebp), %eax

pushl %eax
 
imul %eax, %eax

movl %ebp, %esp
popl %ebp

ret


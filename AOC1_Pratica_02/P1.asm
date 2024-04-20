.data
string: .asciiz "OLA"  
newline: .asciiz "\n"             

.text
.globl main

main:
    li $t0, 0       
    la $t1, string  

loop:
    lb $t2, 0($t1)     
    beqz $t2, done     
    addi $t0, $t0, 1   
    addi $t1, $t1, 1   
    j loop

done:
    move $a0, $t0      
    li $v0, 1          
    syscall            

    la $a0, newline    
    li $v0, 4          
    syscall            

    li $v0, 10         
    syscall            



  
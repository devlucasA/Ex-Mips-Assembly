.data
string: .asciiz "ArqUitetura"
length: .word 11
lowercase_a: .asciiz "a"
uppercase_a: .asciiz "A"
newline: .asciiz "\n"

.text
main:
    la $s0, string       
    lw $s1, length       
    la $t0, lowercase_a 
    la $t1, uppercase_a 
    
    loop:
        lb $t2, 0($s0)   
        beq $t2, $zero, end_loop 
        blt $t2, 65, not_uppercase 
        bgt $t2, 90, not_uppercase 
        
        addi $t2, $t2, 32 
        
        sb $t2, 0($s0)
        
        not_uppercase:
        addi $s0, $s0, 1   
        b loop             
    
    end_loop:
    
    li $v0, 4            
    la $a0, string       
    syscall
    
    li $v0, 4            
    la $a0, newline      
    syscall
    
    li $v0, 10           
    syscall


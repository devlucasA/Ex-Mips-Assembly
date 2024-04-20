        .data
arr:    .space 80
        .align 2
text:   .asciiz "ORDENADOS: "
        .align 2
        .text
main:   addi $v0, $zero, 5
        syscall
        add $s0, $zero, $zero
        add $s1, $zero, $v0
        la $s2, arr
L:      slt $t0, $s0, $s1
        beq $t0, $zero, LEnd
        addi $v0, $zero, 5
        syscall
        sll $t0, $s0, 2
        add $t0, $s2, $t0
        sw $v0, 0($t0)
        addi $s0, $s0, 1
        j L
LEnd:   add $a0, $zero, $s2
        add $a1, $zero, $s1
        jal qsort
        la $a0, text
        addi $v0, $zero, 4
        syscall
        add $s0, $zero, $zero
R:      slt $t0, $s0, $s1
        beq $t0, $zero, REnd
        sll $t0, $s0, 2
        add $t0, $s2, $t0
        lw $a0, 0($t0)
        addi $v0, $zero, 1
        syscall
        addi $a0, $zero, 32
        addi $v0, $zero, 11
        syscall
        addi $s0, $s0, 1
        j R
REnd:   addi $v0, $zero, 10
        syscall
qsort:  addi $sp, $sp, -4
        sw $ra, 0($sp)
        addi $a2, $a1, -1
        add $a1, $zero, $zero
        jal qsortH
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra
qsortH: addi $sp, $sp, -20
        sw $ra, 16($sp)
        sw $s0, 12($sp)
        sw $a0, 8($sp)
        sw $a1, 4($sp)
        sw $a2, 0($sp)
        jal parter
        lw $a0, 8($sp)
        lw $a1, 4($sp)
        lw $a2, 0($sp)
        add $s0, $zero, $v0
        addi $t1, $s0, -1
        slt $t0, $a1, $t1
        beq $t0, $zero, not1
        add $a2, $zero, $t1
        jal qsortH
not1:   slt $t0, $s0, $a2
        beq $t0, $zero, not2
        add $a1, $zero, $s0
        jal qsortH
not2:   lw $ra, 16($sp)
        lw $s0, 12($sp)
        addi $sp, $sp, 20
        jr $ra
parter: addi $sp, $sp, -20
        sw $ra, 16($sp)
        sw $s0, 12($sp)
        sw $s1, 8($sp)
        sw $s2, 4($sp)
        sw $s3, 0($sp)
        add $s0, $zero, $a1
        add $s1, $zero, $a2
        add $t0, $a1, $a2
        srl $t0, $t0, 1
        sll $t0, $t0, 2
        add $t0, $a0, $t0
        lw $s2, 0($t0)
pLoop:  slt $t0, $s1, $s0
        bne $t0, $zero, pEnd
pL1:    sll $t0, $s0, 2
        add $t0, $a0, $t0
        lw $t0, 0($t0)
        slt $t0, $t0, $s2
        beq $t0, $zero, pL2
        addi $s0, $s0, 1
        j pL1
pL2:    sll $t0, $s1, 2
        add $t0, $a0, $t0
        lw $t0, 0($t0)
        slt $t0, $s2, $t0
        beq $t0, $zero, pLE
        addi $s1, $s1, -1
        j pL2
pLE:    slt $t0, $s1, $s0
        bne $t0, $zero, pEnd
        sll $t0, $s0, 2
        add $t0, $a0, $t0
        lw $s3, 0($t0)
        sll $t1, $s1, 2
        add $t1, $a0, $t1
        lw $t2, 0($t1)
        sw $t2, 0($t0)
        sw $s3, 0($t1)
        addi $s0, $s0, 1
        addi $s1, $s1, -1
        j pLoop
pEnd:   add $v0, $zero, $s0
        lw $ra, 16($sp)
        lw $s0, 12($sp)
        lw $s1, 8($sp)
        lw $s2, 4($sp)
        lw $s3, 0($sp)
        addi $sp, $sp, 20
        jr $ra

 


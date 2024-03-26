.data
coefficients:   .word   2, -3, 1     # Coeficientes do polin�mio: 2x^2 - 3x + 1
n:              .word   3           # Grau do polin�mio (n)
x:              .word   2           # Valor de x para avaliar o polin�mio
result:         .word   0           # Vari�vel para armazenar o resultado do polin�mio
output_string:  .asciiz "O valor do polin�mio para x = "
newline:        .asciiz "\n"

.text
.globl main

main:
    # Carregar os coeficientes do polin�mio, o grau do polin�mio (n) e o valor de x
    la $t0, coefficients
    lw $t1, n
    lw $t2, x
    
    # Inicialize o resultado do polin�mio com o primeiro coeficiente
    lw $t3, 0($t0)     # Carregue o primeiro coeficiente
    move $t4, $t3      # $t4 � usado para armazenar o resultado do polin�mio
    
    # Carregue o endere�o do pr�ximo coeficiente do polin�mio
    addi $t0, $t0, 4
    
horner_loop:
    # Verifique se todos os coeficientes foram avaliados
    beq $t1, $zero, end_horner_loop
    
    # Carregue o pr�ximo coeficiente do polin�mio
    lw $t5, 0($t0)
    
    # Atualize o resultado do polin�mio: poly = poly * x + next_coefficient
    mul $t4, $t4, $t2   # poly = poly * x
    add $t4, $t4, $t5   # poly = poly + next_coefficient
    
    # Atualize o grau restante do polin�mio
    subi $t1, $t1, 1
    
    # Avance para o pr�ximo coeficiente do polin�mio
    addi $t0, $t0, 4
    
    # Continue o loop
    j horner_loop
    
end_horner_loop:
    # Armazene o resultado do polin�mio na mem�ria
    sw $t4, result
    
    # Chame a fun��o de impress�o
    jal print_result
    
    # Encerrar o programa
    li $v0, 10
    syscall

print_result:

    
    # Imprimir "O valor do polinomio para x = "
    la $a0, output_string
    li $v0, 4
    syscall
    
    # Carregar o valor de x para imprimir
    lw $a0, x
    li $v0, 1
    syscall
        
    # Imprimir nova linha
    la $a0, newline
    li $v0, 4
    syscall
    
    
    # Carregar o resultado do polin�mio para imprimir
    lw $a0, result
    li $v0, 1
    syscall

    
    jr $ra

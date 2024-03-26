.data
coefficients:   .word   2, -3, 1     # Coeficientes do polinômio: 2x^2 - 3x + 1
n:              .word   3           # Grau do polinômio (n)
x:              .word   2           # Valor de x para avaliar o polinômio
result:         .word   0           # Variável para armazenar o resultado do polinômio
output_string:  .asciiz "O valor do polinômio para x = "
newline:        .asciiz "\n"

.text
.globl main

main:
    # Carregar os coeficientes do polinômio, o grau do polinômio (n) e o valor de x
    la $t0, coefficients
    lw $t1, n
    lw $t2, x
    
    # Inicialize o resultado do polinômio com o primeiro coeficiente
    lw $t3, 0($t0)     # Carregue o primeiro coeficiente
    move $t4, $t3      # $t4 é usado para armazenar o resultado do polinômio
    
    # Carregue o endereço do próximo coeficiente do polinômio
    addi $t0, $t0, 4
    
horner_loop:
    # Verifique se todos os coeficientes foram avaliados
    beq $t1, $zero, end_horner_loop
    
    # Carregue o próximo coeficiente do polinômio
    lw $t5, 0($t0)
    
    # Atualize o resultado do polinômio: poly = poly * x + next_coefficient
    mul $t4, $t4, $t2   # poly = poly * x
    add $t4, $t4, $t5   # poly = poly + next_coefficient
    
    # Atualize o grau restante do polinômio
    subi $t1, $t1, 1
    
    # Avance para o próximo coeficiente do polinômio
    addi $t0, $t0, 4
    
    # Continue o loop
    j horner_loop
    
end_horner_loop:
    # Armazene o resultado do polinômio na memória
    sw $t4, result
    
    # Chame a função de impressão
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
    
    
    # Carregar o resultado do polinômio para imprimir
    lw $a0, result
    li $v0, 1
    syscall

    
    jr $ra

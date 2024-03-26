.data
coefficients:   .word   2, -3, 1     # Coeficientes do polinômio: 2x^2 - 3x + 1
n:              .word   3           # Grau do polinômio (n)

# Valor de x para avaliar o polinômio
x:              .float 2.0

# Variável para armazenar o resultado do polinômio
result:         .word 0

# String para impressão
output_string:  .asciiz "O valor do polinomio para x = "
newline:        .asciiz "\n"

.text
.globl main

main:
    # Carregar os coeficientes do polinômio, o grau do polinômio (n) e o valor de x
    la $t0, coefficients
    lw $t1, n
    l.s $f2, x
    
    # Inicializar o resultado do polinômio como zero
    li $t3, 0           # $t3 é usado para armazenar o resultado do polinômio
    
    # Inicializar o expoente do polinômio como n-1
    sub $t4, $t1, 1     # $t4 é usado para armazenar o expoente do polinômio
    
evaluate_polynomial:
    # Carregar o próximo coeficiente do polinômio
    lw $t5, 0($t0)
    
    # Carregar o próximo expoente
    move $t6, $t4
    
    # Calcular x^(n-1-i)
    li $t7, 1
    loop_power:
        beq $t6, $zero, end_loop_power
        mul.s $f12, $f12, $f2
        subi $t6, $t6, 1
        j loop_power
    end_loop_power:
    
    # Adicionar ao resultado atual
    mul $t5, $t5, $t7
    add $t3, $t3, $t5
    
    # Atualizar o próximo coeficiente e o próximo expoente
    addi $t0, $t0, 4     # Avançar para o próximo coeficiente
    subi $t4, $t4, 1     # Decrementar o expoente
    
    # Verificar se todos os coeficientes foram avaliados
    bne $t4, $zero, evaluate_polynomial
    
    # Armazenar o resultado do polinômio na memória
    sw $t3, result
    
    # Chamar a função de impressão
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
    l.s $f12, x
    li $v0, 2
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


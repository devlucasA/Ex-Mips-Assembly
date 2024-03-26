.data
x: .space 4   # Mudamos para .space para reservar espaço para o inteiro
n: .space 4   # Mudamos para .space para reservar espaço para o inteiro
resultado: .space 4  

.text
.globl main

main:
    # Ler x do teclado
    li $v0, 5         # syscall 5 para ler um inteiro
    syscall           # Chama o sistema

    move $t0, $v0     # Salva o valor de x em $t0
    sw $t0, x         # Armazena o valor de x na memória

    # Ler n do teclado
    li $v0, 5         # syscall 5 para ler um inteiro
    syscall           # Chama o sistema

    move $t1, $v0     # Salva o valor de n em $t1
    sw $t1, n         # Armazena o valor de n na memória

    lw $a0, x         # Carrega o valor de x
    lw $a1, n         # Carrega o valor de n
    jal expo1         # Chama a função expo1

    sw $v0, resultado # Armazena o resultado

    # Mostra o resultado
    li $v0, 1         # syscall 1 para imprimir inteiro
    lw $a0, resultado # Carrega o resultado
    syscall           # Chama o sistema

    li $v0, 10        # syscall 10 para terminar o programa
    syscall           # Chama o sistema

expo1:
    li $t0, 1         # Inicializa o acumulador com 1

while_loop:
    blez $a1, end_while     # Se n <= 0, termina o loop
    mul $t0, $t0, $a0       # Multiplica acumulador por x
    addi $a1, $a1, -1       # Decrementa n
    j while_loop

end_while:
    move $v0, $t0    # Move o resultado para $v0
    jr $ra           # Retorna


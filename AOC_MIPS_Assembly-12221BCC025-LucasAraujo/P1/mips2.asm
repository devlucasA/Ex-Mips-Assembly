.data
x: .space 4             # Reserva espaço para o inteiro x
n: .space 4             # Reserva espaço para o inteiro n
result: .space 4        # Reserva espaço para o resultado

.text
.globl main
.globl expo2

main:
    # Ler x do teclado
    li $v0, 5             # syscall 5 para ler um inteiro
    syscall               # Chama o sistema
    move $t0, $v0         # Salva o valor de x em $t0
    sw $t0, x             # Armazena o valor de x na memória

    # Ler n do teclado
    li $v0, 5             # syscall 5 para ler um inteiro
    syscall               # Chama o sistema
    move $t1, $v0         # Salva o valor de n em $t1
    sw $t1, n             # Armazena o valor de n na memória

    # Chamada para a função expo2
    move $a0, $t0         # Argumento 1: x
    move $a1, $t1         # Argumento 2: n
    jal expo2             # Chama a função expo2

    move $t2, $v0         # Salva o resultado retornado em $t2
    sw $t2, result        # Armazena o resultado em result

    # Impressão do resultado
    li $v0, 1             # syscall 1 para imprimir inteiro
    move $a0, $t2         # Carrega o resultado
    syscall               # Chama o sistema

    # Sair do programa
    li $v0, 10            # syscall 10 para terminar o programa
    syscall               # Chama o sistema

expo2:
    # Argumentos:
    # $a0: x
    # $a1: n
    # Retorno:
    # $v0: resultado

    # Inicializa o resultado como 1
    li $t2, 1
    move $v0, $t2         # Move 1 para $v0 (resultado)

loop:
    beqz $a1, end_loop    # Se n = 0, termina o loop
    andi $t3, $a1, 1      # Verifica se n é ímpar
    beq $t3, $zero, skip # Se n for par, pula para skip

    mul $v0, $v0, $a0     # Multiplica o resultado por x

skip:
    srl $a1, $a1, 1       # Divide n por 2 (desloca para direita)
    mul $a0, $a0, $a0     # Eleva x ao quadrado
    j loop

end_loop:
    jr $ra                # Retorna


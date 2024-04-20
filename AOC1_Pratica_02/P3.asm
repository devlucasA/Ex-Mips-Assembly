.data
condicao:   .float 0.00001

inserir: .asciiz "Insira em graus o angulo desejado: "
resultado: .asciiz "O resultado em radianos e: "

pi: .float 3.141592 # Definindo o valor de Pi
valor: .float 0.0
numero_1: .float 1.0
numero_2: .float 2.0
negativo: .float -1.0 # Valor negativo -1
grau_180: .float 180.0 # Valor de 180 Graus


.text
.globl main

main:
    # Exibe uma mensagem para que o angulo seja inserido em graus
    li $v0, 4
    la $a0, inserir
    syscall

    # Lê o valor do ângulo 
    li $v0, 6
    syscall
    lwc1 $f4, valor      # Carregar o valor zero em $f4
    add.s $f12,$f0,$f4  # $f12 = 'angulo'


    # Converte o ângulo de graus para radianos
    lwc1 $f3, grau_180
    div.s $f12, $f12, $f3
    lwc1 $f3, pi
    mul.s $f12, $f12, $f3 # $f2 armazena o grau em RAD. *PI
    
    #Imprime o valor do resultado
    li $v0, 4
    la $a0, resultado
    syscall

    # Implementando o termo e  inicializando os valores iniciais necessários  para o resultado com o primeiro termo da série (x)
    mov.s $f2, $f12 # inicializando meu termo $f2 em radianos
    mov.s $f3, $f12  # inicializando meu resultado $f3 em radianos
    
    mul.s $f1, $f12, $f12   # multiplica o valor dos radianos
    
    #Carregando o valor de -1.0 para que minha função seno alterne entre valores positivos e negativos
    lwc1 $f10, negativo
    
    # Multiplicando -1 com o valor do radiano ao quadrado 
    mul.s $f1, $f1, $f10   
    
    lwc1 $f5, numero_1  # carregar o valor 1 para meu contador
    lwc1 $f11, numero_1
    
loop: #Loop que calcula cada termo da série de taylor

    # Calculando os termos do meu denominador em $f4 
    lwc1 $f4, numero_2 # Valor do denominador
    mul.s $f4,$f4,$f5 # Multiplicando
    lwc1 $f7, numero_2 # Constante 2
    
    lwc1 $f7,numero_1 # Valor 1
    add.s $f7, $f5, $f7 
    
    lwc1 $f8, numero_2 
    mul.s $f7, $f7, $f8    
    
    mul.s $f4, $f4, $f7 # (2*K) * (2*(K+1))
     
    # Calculando o próximo termo da série
    div.s $f6, $f1, $f4 # -1.0 * radianos * rad / ((2 * k) * (2 * k + 1));
    mul.s $f2, $f2, $f6 
    
    add.s $f3, $f3, $f2 
    add.s $f5, $f5,$f11  
    
    #condiçao de parada
    
    abs.s $f7, $f2  
    
    lwc1 $f8, condicao
    c.lt.s $f7, $f8
    bc1t final
    
    # Repete o loop
    j loop
 
   
final:
    # Exibindo os resultados
    li $v0, 2
    mov.s $f12, $f3
    syscall

    # Encerra o programa
    li $v0, 10
    syscall
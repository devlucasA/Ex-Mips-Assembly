.data
    # Definindo as variáveis
    
    pi: .double 3.141592
    numero_1: .double 1
    numero_2: .double 2
    radianos: .double 180
    precisao: .double 0.00001
    msg: .asciiz "Insira o valor do ângulo em radianos: " 
    resultado: .asciiz "O cosseno do ângulo é: "
    
.text
    li $v0, 4
    la $a0, msg
    syscall
    
    li $v0, 7
    syscall
    mov.d $f2, $f0
    
    jal conversao    
    
    jal cosex
    
    li $v0, 4
    la $a0, resultado
    syscall
    
    li $v0, 3
    mov.d $f12, $f4
    syscall
    
    li $v0, 10
    syscall
    
    
    conversao:
        l.d $f4, pi    
        l.d $f6, radianos    
        
        mul.d $f2, $f2, $f4    
            
        div.d $f2, $f2, $f6    
        
        jr $ra            
        
    pot: 
        l.d $f10, numero_1    
        loopPow:
            beqz $t1, end        
            mul.d $f10, $f10, $f2    
            subiu $t1, $t1, 1    
            j loopPow        
                
            
        
    end: 
        jr $ra            
        
        
    atualiza: 
        
        addiu $t0, $t0, 1
        add.d $f14, $f14, $f20
            
        j loop
        
    termo: 
        
        add.d $f4, $f4, $f6    
        j atualiza
        
    
    loop: 
    
            c.le.d $f6, $f18    
            bc1t fim        
            
            mul $t1, $t0, 2    
            jal pot    
            mov.d $f6, $f10        
        
            mul.d $f16, $f14, $f22  
            mul.d $f8, $f8, $f16    
            sub.d $f16, $f16, $f20  
            mul.d $f8, $f8, $f16    
            div.d $f6, $f6, $f8    

            li $t2, 2 
            div $t0, $t2 
                
            mfhi $t2  
            
            beqz $t2, termo    
            
            sub.d $f4, $f4, $f6 
            
            
        fim: 
                
            move $ra, $t8        
            jr $ra 
    
    cosex: 
    
        move $t8, $ra    
        l.d $f4,numero_1 
        l.d $f8, numero_1 
        li $t0, 1     
        l.d $f14, numero_1 
        
        l.d $f20, numero_1 
        l.d $f22, numero_2 
        
        l.d $f18, precisao  

        jal loop 
        
        jr $ra 








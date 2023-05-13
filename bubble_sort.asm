.data
	lista: 	     .word   44, 86, 8, 72, 11, 46, 51, 83, 88, 87
	limite:      .word   10
	maior:       .word   0
	indiceMaior: .word   0
	aux:         .word   0
	pularLinha:  .asciiz "\n"

.text
ordenacao:
	lw $t1, limite
	sgt $t1, $t1, $zero
	bne $t1, 1, fim_ordenacao #while limite > 0
	la $t1, lista #endereço de lista[0]
	lw $t1, 0($t1) #valor de lista[0]
	la $t2, maior #endereço de maior
	sw $t1, 0($t2) #maior = lista[0]
	li $t1, 0
	la $t2, indiceMaior
	sw $t1, 0($t2) #indiceMaior = 0
	li $t1, 0 #i
for:
	lw $t2, limite
	beq $t1, $t2, fim_for #for i in range(limite)
	la $t2, lista
	add $t4, $t1, $zero
	sll $t1, $t1, 2
	add $t2, $t2, $t1 #endereço de lista[i]
	add $t1, $t4, $zero
	lw $t2, 0($t2) #valor de lista[i]
	lw $t3, maior
	sgt $t4, $t2, $t3
	beq $t4, 0, fim_if #if lista[i] > maior
	la $t3, maior
	sw $t2, 0($t3) #maior = lista[i]
	la $t3, indiceMaior
	sw $t1, 0($t3) #indiceMaior = i
fim_if:
	addi $t1, $t1, 1 #i++
	j for
fim_for:
	lw $t2, limite
	addi $t2, $t2, -1
	sll $t2, $t2, 2
	la $t3, lista
	add $t3, $t3, $t2 #endereço de lista[limite-1]
	lw $t4, 0($t3) #valor de lista[limite-1]
	la $t2, aux
	sw $t4, 0($t2) #aux = lista[limite-1]
	lw $t2, maior
	sw $t2, 0($t3) #lista[limite-1] = maior
	la $t1, lista
	lw $t2, indiceMaior
	sll $t2, $t2, 2
	add $t3, $t2, $t1 #endereço de lista[indiceMaior]
	lw $t2, aux
	sw $t2, 0($t3) #lista[indiceMaior] = aux
	la $t1, limite
	lw $t2, 0($t1)
	addi $t2, $t2, -1
	sw $t2, 0($t1) #limite -= 1
	j ordenacao
fim_ordenacao:
	#print(lista)
	li $v0, 1
	la $t1, lista
	lw $a0, 0($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 4($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 8($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 12($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 16($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 20($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 24($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 28($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 32($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 1
	la $t1, lista
	lw $a0, 36($t1)
	syscall
	li $v0, 4
	la $a0, pularLinha
	syscall
	
	li $v0, 10
	syscall

#load: lw, la, li
#comparação: sgt
#branch: bne, beq
#store: sw
#shift: sll
#soma: add, addi
#jump: j
#5 registradores
#~50 instruções
#vetor com 10 números
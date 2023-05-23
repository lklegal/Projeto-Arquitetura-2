.data
	lista: 	     .word   44, 86, 8, 72, 11, 46, 51, 83, 91, 87
	limite:      .word   10
	maior:       .word   0

.text
	la $t1, lista #endereço de lista[0]
	lw $t1, 0($t1) #valor de lista[0]
	la $t2, maior #endereço de maior
	sw $t1, 0($t2) #maior = lista[0]
	add $t1, $zero, $zero #i
for:
	lw $t2, limite
	beq $t1, $t2, fim_for #for i in range(limite)
	la $t2, lista
	add $t4, $t1, $zero #não vai precisar
	sll $t1, $t1, 2 #não vai precisar disso, no processador os endereços vão ser de 1 em 1, não de 4 em 4
	add $t2, $t2, $t1 #endereço de lista[i]
	add $t1, $t4, $zero #não vai precisar
	lw $t2, 0($t2) #valor de lista[i]
	lw $t3, maior
	sgt $t3, $t2, $t3
	beq $t3, $zero, fim_if #if lista[i] > maior
	la $t3, maior
	sw $t2, 0($t3) #maior = lista[i]
fim_if:
	addi $t1, $t1, 1 #i++ #teremos o registrador $one, então a instrução ficaria add $t1, $t1, $one
	j for
fim_for:
	#print(maior)
	li $v0, 1
	la $t1, maior
	lw $a0, 0($t1)
	syscall

	li $v0, 10
	syscall

#load: lw(000), li(001)
#comparação: sgt(010)
#branch: beq(011)
#store: sw(100)
#soma: add(101)
#jump: j(110)
#6 registradores
#20 instruções
#vetor com 10 números

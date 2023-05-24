#load: lw(000), li(001)
#comparação: sgt(010)
#branch: beq(011)
#store: sw(100)
#soma: add(101)
#jump: j(110)
#6 registradores
#20 instruções
#vetor com 10 números

#0	001 010 0000000000     -> li $t1, 0 
#1	000 010 010 0000000    -> lw $t1, $t1
#2	001 011 0000001011     -> li $t2, 11
#3	100 010 011 0000000    -> sw $t1, $t2
#4	101 010 000 000 0000   -> add $t1, $zero, $zero
#5  001 101 0000001010     -> li $la, 10
#6	000 011 101 0000000    -> lw $t2, $la
#7	011 010 011 0010011    -> beq $t1, $t2, 19
#8	001 011 0000000000     -> li $t2, 0
#9	101 011 011 010 0000   -> add $t2, $t2, $t1
#10	000 011 011 0000000    -> lw $t2, $t2
#11 001 101 0000001011     -> li $la, 11
#12	000 100 101 0000000    -> lw $t3, $la
#13	010 100 011 100 0000   -> sgt $t3, $t2, $t3
#14	011 100 000 0010001    -> beq $t3, $zero, 17
#15	001 100 0000001011     -> li $t3, 11
#16	100 011 100 0000000    -> sw $t2, $t3
#17	101 010 010 001 0000   -> add $t1, $t1, $one
#18	110 0000000000101      -> j 5
#19 110 0000000010011      -> fim, loop infinito nessa linha

def controle(mem_dados, banco_reg, pc, instr_cod):
    instr_dec = instr_cod.split('-')
    if(int(instr_dec[0]) == 0):
        lw(int(instr_dec[1]), int(instr_dec[2]), banco_reg, mem_dados)
    if(int(instr_dec[0]) == 1):
        li(int(instr_dec[1]), int(instr_dec[2]), banco_reg)
    if(int(instr_dec[0]) == 2):
        sgt(int(instr_dec[1]), int(instr_dec[2]), int(instr_dec[3]), banco_reg)
    if(int(instr_dec[0]) == 3):
        beq(int(instr_dec[1]), int(instr_dec[2]), int(instr_dec[3]), banco_reg, pc)
    if(int(instr_dec[0]) == 4):
        sw(int(instr_dec[1]), int(instr_dec[2]), banco_reg, mem_dados)
    if(int(instr_dec[0]) == 5):
        add(int(instr_dec[1]), int(instr_dec[2]), int(instr_dec[3]), banco_reg)
    if(int(instr_dec[0]) == 6):
        j(int(instr_dec[1]), pc)

def lw(reg_dest, reg_endereco, banco_reg, mem_dados):
    banco_reg[reg_dest] = mem_dados[banco_reg[reg_endereco]]

def li(reg_dest, imediato, banco_reg):
    banco_reg[reg_dest] = imediato

def sgt(reg_dest, reg1, registrador_dois, banco_reg):
    if(banco_reg[reg1] > banco_reg[registrador_dois]):
        banco_reg[reg_dest] = 1
    else:
        banco_reg[reg_dest] = 0

def beq(reg1, registrador_dois, endereco, banco_reg, pc):
    if(banco_reg[reg1] == banco_reg[registrador_dois]):
        pc[0] = endereco-1

def sw(reg_alvo, reg_endereco, banco_reg, mem_dados):
    mem_dados[banco_reg[reg_endereco]] = banco_reg[reg_alvo]

def add(reg_dest, reg1, reg2, banco_reg):
    banco_reg[reg_dest] = banco_reg[reg1] + banco_reg[reg2]

def j(endereco, pc):
    pc[0] = endereco-1

if __name__ == "__main__":
    mem_dados = [44, 86, 8, 72, 11, 46, 51, 83, 91, 87, 10, 0]
    #mem_instr = ['0010100000000000', '0000100100000000', '0010110000001011', '1000100110000000', '1010100000000000',
    #                      '0011010000001010', '0000111010000000', '0110100110010011', '0010110000000000', '1010110110100000',
    #                      '0000110110000000', '0011010000001011', '0001001010000000', '0101000111000000', '0111000000010001',
    #                      '0011000000001011', '1000111000000000', '1010100100010000', '1100000000000101','1100000000010011']
    mem_instr = ['1-2-0', '0-2-2', '1-3-11', '4-2-3', '5-2-0-0', '1-5-10', '0-3-5', '3-2-3-19', '1-3-0', '5-3-3-2', 
                          '0-3-3', '1-5-11', '0-4-5', '2-4-3-4', '3-4-0-17', '1-4-11', '4-3-4', '5-2-2-1', '6-5'] 
    #sem a última instrução,'6-19', na memória, para não ficar num loop infinito, e os pedaços da instrução estão em decimal 
    #para facilitar
    banco_reg = [0, 1, 0, 0, 0, 0] #[$zero, $one, $t1, $t2, $t3, $la]
    pc = [0]

    while pc[0] < len(mem_instr):
        instrucao = mem_instr[pc[0]]
        controle(mem_dados, banco_reg, pc, instrucao)
        pc[0] += 1

    print(mem_dados[11]) #imprime 91
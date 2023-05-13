import random

lista = []

for i in range(10):
    lista.append(random.randint(0, 100))

print(lista)

limite = len(lista)
while limite > 0:
    maior = lista[0]
    indiceMaior = 0
    for i in range(limite):
        if lista[i] > maior:
            maior = lista[i]
            indiceMaior = i
    aux = lista[limite-1]
    lista[limite-1] = maior
    lista[indiceMaior] = aux
    limite -= 1

print(lista)

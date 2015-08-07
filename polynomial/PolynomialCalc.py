import math
import numpy as np  
import matplotlib.pyplot as plt  

def graph(formula, first, last):  
    x = np.linspace(first,last,100)
    y = eval(formula)
    plt.plot(x, y)  
    plt.show()

common = 0
degree = 0
data = []
numofnums = input("How many numbers are there? ")
for x in range(numofnums):
    num = input("Enter the "+str((x+1))+" number: ")
    data.append(num)
print data
difs = [data]
for x in range(numofnums-1):
    difs.append([])
for x in range(numofnums-1):
    for y in range(numofnums-1-x):
        difs[x+1].append(difs[x][y+1]-difs[x][y])
print difs
for x in range(numofnums):
    a = difs[x][0]
    same = 0
    for y in range(numofnums-x):
        if difs[x][y] != a:
            same = 1
    if same == 0:
        degree = x
        break
print "The degree is "+str(degree)
degstuff = []
for x in range(degree+1):
    degstuff.append([])
for x in range(degree+1):
    for y in range(degree+1-x):
        degstuff[x].append([])
        for z in range(degree+1-x):
            degstuff[x][y].append([])
for x in range(degree+1):
    for y in range(degree+1):
        degstuff[0][degree-x][y] = (y+1)**(x)
for x in range(degree):
    for y in range(degree-x):
        for z in range(degree-x):
            degstuff[x+1][y][z] = degstuff[x][y][z+1]-degstuff[x][y][z]
#print degstuff
coefficients = []
for x in range(degree+1):
    modco = []
    if x != 0:
        for y in range(x):
            modco.append(coefficients[y])
        for y in range(x):
            modco[y] = modco[y]*(degstuff[degree-x][y][0])
        modsum = sum(modco)
    else:
        modsum = 0
    coefficients.append(((difs[degree-x][0])-modsum)/(degstuff[degree-x][x][0]))
    #print coefficients[x]
print coefficients
expression = "0"
for x in range(len(coefficients)):
    expression = expression+"+"+str(coefficients[x])+"*x**"+str(len(coefficients)-x-1)
print expression
graph(expression, 0, numofnums+1)

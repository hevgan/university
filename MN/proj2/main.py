import numpy as np
import math
from icecream import ic
from time import time
import timeit

Index = list(map(int, "175854"))
N = 900 + 10*Index[-2]+Index[-1]
norm = 10**-6
B_norm = 10**-9

def timethis(func):
    def wrapper(*args, **kwargs):
        t0 = time()
        result = func(*args, **kwargs)
        if(func.__name__ == 'LU_solve'):
            print(f"{func.__name__}:{time()-t0}[s]\tresiduum: {result}", )
            return result
        else:
            if(result==(math.inf,math.inf)):
                print(f"{func.__name__} does not converge for this data!")
            else:
                print(f"{func.__name__}: {time()-t0}[s]\titerations: {result[0]}\tresiduum: {result[1]}")
            return result
    return wrapper

@timethis    
def GaussSeidl(A,b, eps):

    N = len(b)
    x = np.zeros(N)
    L = np.tril(A)
    U = A - L

    iterations = 0
    current_res = 1
    
    while current_res > eps and not np.isnan(current_res) and not np.isinf(current_res):
        iterations+=1
        x = np.dot(np.linalg.inv(L), b - np.dot(U, x))
        current_res = np.linalg.norm(np.matmul(A,x)-b)
    return (math.inf, math.inf) if (np.isnan(current_res) or np.isinf(current_res)) else (iterations,current_res, x)

@timethis
def Jacobi(A,b, eps):

    N = len(b)
    x = np.zeros(N)
    L = np.tril(A, -1)
    U = np.triu(A, 1)
    D = np.diag(A)
    fst = -(L+U) / D
    snd = b / D

    iterations = 0
    current_res = 1

    while current_res > eps and not np.isnan(current_res) and not np.isinf(current_res):
        iterations+=1
        x = np.matmul(fst, x) + snd
        current_res = np.linalg.norm(np.matmul(A,x)-b)
    return (math.inf, math.inf) if (np.isnan(current_res) or np.isinf(current_res)) else (iterations,current_res, x)

@timethis    
def LU_solve(A, b, B_norm):
    rows, cols = A.shape

    for i in np.arange(0, cols):
        pivot = A[i, i]
        if abs(pivot) < B_norm:
            break
        for k in np.arange(i + 1, cols):
            A[k, i] = A[k, i] / pivot
            A[k, i + 1:cols] = A[k, i + 1:cols] - A[k, i] * A[i, i + 1:cols]
    L = np.eye(cols) + np.tril(A, -1)
    U = np.triu(A)

    y = np.zeros_like(b)
    for i in range(N):
        s = np.dot(L[i, :i], y[:i])
        y[i] = b[i] - s

    x = np.zeros_like(y)
    for i in range(N, 0, -1):
        x[i - 1] = (y[i - 1] - np.dot(U[i - 1, i:], x[i:])) / U[i - 1, i - 1]

    return np.linalg.norm(np.matmul(A, x) - b)

def genMatrix(N, Index, n=None):
    
    e = Index[3]
    a1 = n or 5+e
    a2 = a3 = -1
    f = Index[2]
    b = [math.sin(i*(f+1)) for i in range(N)]

    A = np.identity(N)*a1
    for w in range(N):
        for k in range(N):
            if(abs(w-k)==1):
                A[w][k] = A[k][w] = a2
            if(abs(w-k)==2):
                A[w][k] = A[k][w] = a3

    return A, b


A, b = genMatrix(N, Index)
GaussSeidl(A, b, B_norm)
Jacobi(A, b, B_norm)

A3, b3 = genMatrix(N, Index, 3)
#ic(A3)
#Jacobi(A3, b3, B_norm)
#GaussSeidl(A3, b3, B_norm)

LU_solve(A3, b3, B_norm)

#TODO
#fix LU decomposition method

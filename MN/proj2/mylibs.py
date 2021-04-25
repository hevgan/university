import numpy as np
import math
from time import time
import timeit
import matplotlib.pyplot as plt

Index = list(map(int, "175854"))
N = 900 + 10 * Index[-2] + Index[-1]
norm = 10 ** -6
B_norm = 10 ** -9


def timethis(func):
    def wrapper(*args, **kwargs):

        t0 = time()
        result = func(*args, **kwargs)
        t1 = time() - t0
        if func.__name__ == "LU_solve":
            print(f"{func.__name__}:{t1}[s]\nresiduum: {result}\n")
            return {"time" : t1, "result" : result}
        else:
            if result == (math.inf, math.inf):
                print(f"{func.__name__} does not converge for this data!\n")
            else:
                print(f"{func.__name__}: {t1}[s]\niterations: {result[0]}\tresiduum: {result[1]}\n")
            return {"time" : t1, "result" : result}

    return wrapper


@timethis
def GaussSeidl(A, b, eps):

    x = np.zeros(len(b))
    L = np.tril(A)
    U = A - L

    iterations = 0
    current_res = 1

    while current_res > eps and not np.isnan(current_res) and not np.isinf(current_res):
        iterations += 1
        x = np.dot(np.linalg.inv(L), b - np.dot(U, x))
        current_res = np.linalg.norm(np.matmul(A, x) - b)
    return (math.inf, math.inf) if (np.isnan(current_res) or np.isinf(current_res)) else (iterations, current_res, x)


@timethis
def Jacobi(A, b, eps):

    x = np.zeros(len(b))
    L = np.tril(A, -1)
    U = np.triu(A, 1)
    D = np.diag(A)
    fst = -(L + U) / D
    snd = b / D

    iterations = 0
    current_res = 1

    while current_res > eps and not np.isnan(current_res) and not np.isinf(current_res):
        iterations += 1
        x = np.matmul(fst, x) + snd
        current_res = np.linalg.norm(np.matmul(A, x) - b)
    return (math.inf, math.inf) if (np.isnan(current_res) or np.isinf(current_res)) else (iterations, current_res, x)


@timethis
def LU_solve(A, b, eps):

    rows, cols = A.shape
    iterations = 0
    current_res = 1

    for i in range(cols):
        pivot = A[i, i]
        if abs(pivot) < eps:
            break
        for k in range(i + 1, cols):
            A[k, i] = A[k, i] / pivot
            A[k, i + 1 : cols] = A[k, i + 1 : cols] - A[k, i] * A[i, i + 1 : cols]
    L = np.eye(cols) + np.tril(A, -1)
    U = np.triu(A)

    y = np.zeros_like(b)
    for i in range(len(b)):
        s = np.dot(L[i, :i], y[:i])
        y[i] = b[i] - s

    x = np.zeros_like(b)
    for i in range(len(x), 0, -1):
        x[i - 1] = (y[i - 1] - np.dot(U[i - 1, i:], x[i:])) / U[i - 1, i - 1]
    current_res = np.linalg.norm(np.matmul(A, x) - b)
    return current_res


def genMatrix(N, Index, n=None):

    e = Index[3]
    a1 = n or 5+e
    a2 = a3 = -1
    f = Index[2]
    b = [np.sin(i * (f + 1)) for i in range(N)]

    A = np.diag(np.full(N, [a1]))
    # A = np.identity(N) * a1
    # Both methods generate identical matrices but only the second one works 
    # residuum for the commented out method skyrockets
    # ic(np.array_equal(A, A2)) 

    # WTF 

    for w in range(N):
        for k in range(N):
            if abs(w - k) == 1:
                A[w][k] = A[k][w] = a2
            if abs(w - k) == 2:
                A[w][k] = A[k][w] = a3

    return A, b


def shortPlot(x, y, name, extension, linewidth):
    
    fig, ax = plt.subplots(figsize=(15, 8))

    ax.plot(x, y["Jacobi"], label="Jacobi method", color="b", linewidth=linewidth)
    ax.scatter(x, y["Jacobi"])
    ax.plot(x, y["Gauss-Seidl"], label="Gauss-Seidel method", color="r", linewidth=linewidth)
    ax.scatter(x, y["Gauss-Seidl"])
    ax.plot(x, y["LU"], label="LU method", color="y", linewidth=linewidth)
    ax.scatter(x, y["LU"])

    plt.xlabel("Size of a matrix")
    plt.ylabel("Time[s]")
    plt.legend(loc="upper left", frameon=True)
    plt.title("Linear equation solving algorythm comparision")

    plt.savefig(f"{name}.{extension}")

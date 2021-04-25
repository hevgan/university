from mylibs import *
# A & B
A, b = genMatrix(N, Index)
Jacobi(A, b, norm)
GaussSeidl(A, b, norm)
# C
A, b = genMatrix(N, Index, 3)
Jacobi(A, b, B_norm)
GaussSeidl(A, b, B_norm)
# D
LU_solve(A, b, B_norm)

# E
times = {
"Jacobi" : [],
"Gauss-Seidl": [],
"LU": []
}

sizes = [100, 500, 1000, 2000, 3000]

for _, size in enumerate(sizes):
    A, b = genMatrix(size, Index) 
    times["Jacobi"].append( Jacobi(A, b, norm)["time"] )
    times["Gauss-Seidl"].append( GaussSeidl(A, b, norm)["time"] )
    times["LU"].append( LU_solve(A, b, norm)["time"] )

shortPlot(x = sizes, y = times, name = 'result',
extension = 'png', linewidth = 2)


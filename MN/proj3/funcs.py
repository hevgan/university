import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
import sys
import subprocess
from icecream import ic
import itertools
import random
import numpy as np
import numpy.polynomial.polynomial as poly
import matplotlib.pyplot as plt
import itertools as it
from enum import Enum
plt.rcParams.update({'figure.max_open_warning': 0})

default_num_of_lagrange_interpolation_points = 20

elevation_profiles = [r'WielkiKanionKolorado'] #, r'SpacerniakGdansk',r'Obiadek', r'WielkiKanionKolorado', r'100'] #MountEverest


class interpolationPlotType(Enum):
    both = 0
    lagrange = 1
    splines = 2


def loadTerraindata(name):
    data = pd.read_csv(f'./profiles/{name}.csv', names=('dist', 'height'))

    x = list(data['dist'])
    y = list(data['height'])
    x = list(x[1:])
    y = list(y[1:])
    x = list(map(lambda data: int(float(data)), x))
    y = list(map(lambda data: int(float(data)), y))

    return x, y


def displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x, splines_y, name, point_count, ind, plot_type):

    fig = plt.figure()
    plt.plot(x, y, label='actual terrain')


    #TODO refactor this ugly shit
    if plot_type == interpolationPlotType.both:  # both
        plt.plot(lagrange_x, lagrange_y, label='lagrange',
                 linestyle=":", c='orange')
        plt.plot(splines_x, splines_y, label='cubic splines',
                 linestyle=":", c='black')
        #plt.scatter(splines_x, splines_y)

        folder = "both"
    elif plot_type == interpolationPlotType.lagrange:  # lagrange
        plt.plot(lagrange_x, lagrange_y, label='lagrange',
                 linestyle=":", c='orange')
        folder = "lagrange"
    elif plot_type == interpolationPlotType.splines:  # splines
        plt.plot(splines_x, splines_y, label='cubic splines',
                 linestyle=":", c='black')
        #plt.scatter(splines_x, splines_y)
        folder = "splines"

    plt.scatter(chosen_x, chosen_y, label='interpolation points', c='green')
    plt.legend()
    plt.title(
        f"interpolated heights for \"{name}.csv\" for {point_count} points")
    plt.xlabel("distance [m]")
    plt.ylabel("height [m]")

    fig.set_figwidth(4)
    fig.set_figwidth(7)

    plt.savefig(f"./plots/{folder}/{name}/{ind}-num_of_points-{point_count}")
    plt.show()
    plt.clf()


def getEvenlyDistributedPoints(x, y, num_of_points=default_num_of_lagrange_interpolation_points):

    assert len(x) == len(y)

    points = np.round(np.linspace(0, len(x) - 1, num_of_points+1, endpoint=True)).astype(int)
    points = [(x[i], y[i]) for i in points]

    chosen_x = [points[i][0] for i in range(len(points))]
    chosen_y = [points[i][1] for i in range(len(points))]

    return chosen_x, chosen_y, points


def getLagrangeInterpolationValues(x, y, interpolating_points_count, full_x_data):

    #interpolating_points_count = interpolating_points_count or default_num_of_lagrange_interpolation_points
    #interpolating_points_count = interpolating_points_count if interpolating_points_count % 2 == 0 else interpolating_points_count+1
    #start = x[0]
    #stop = x[-1]
    data_length = len(full_x_data)
    interpolating_points_count = data_length
    #result_x = np.linspace(start, stop, num=interpolating_points_count, endpoint=True)
    result_x = full_x_data
    #ic(result_x)
    result_y = [0] * interpolating_points_count

    for n in range(interpolating_points_count):
        sum = 0.0
        for i in range(len(x)):
            product = 1.0
            for j in range(len(x)):
                if (i != j):
                    product *= (result_x[n]-x[j])
                    product /= (x[i]-x[j])
            sum = sum + product * y[i]
        result_y[n] = sum

    assert interpolating_points_count == len(result_y) == len(result_x)

    return result_x, result_y


def pivotingLU(A, b):

    N, n = np.shape(A)
    L = np.eye(n)
    P = np.eye(n)
    U = A

    for i in range(n-1):

        best = np.absolute(U[i][0])
        ind = 0

        for j in range(i, n):
            if(np.absolute(U[j][i]) > best):
                best = np.absolute(U[j][i])
                ind = j

        for k in range(i, n):
            U[ind][k], U[i][k] = U[i][k],  U[ind][k]

        for k in range(i):
            L[ind][k], L[i][k] = L[i][k], L[ind][k]

        for k in range(n):
            P[ind][k], P[i][k] = P[i][k], P[ind][k]

        for j in range(i+1, n):
            L[j][i] = U[j][i]/U[i][i]
            for k in range(i, n):
                U[j][k] = U[j][k] - L[j][i] * U[i][k]

    y = np.ones(n)
    b = np.dot(P, b)

    for i in range(n):
        val = b[i]
        for j in range(i):
            if j != i:
                val -= L[i][j] * y[j]
        y[i] = val / L[i][i]

    x = np.zeros(n)
    for i in range(n - 1, -1, -1):
        val = y[i]
        for j in range(i, n):
            if j != i:
                val -= U[i][j] * x[j]
        x[i] = val / U[i][i]

    return x


def cubicSplineInterpolation(x, y):
    m = len(x)
    n = m-1

    data = list(zip(x, y))
    h = float(data[1][0]) - float(data[0][0])

    A = np.zeros((4*n, 4*n))
    b = np.zeros((4*n))

    for i in range(n):
        A[i][4*i] = float(1)
        b[i] = float(data[i][1])

    for i in range(n):
        A[n+i][4*i] = float(1)
        A[n+i][4*i + 1] = h
        A[n+i][4*i + 2] = h ** 2
        A[n+i][4*i + 3] = h ** 3
        b[n+i] = float(data[i+1][1])

    for i in range(n - 1):
        A[2*n + i][4 * i + 1] = float(1)
        A[2*n + i][4 * i + 2] = 2 * h
        A[2*n + i][4 * i + 3] = 3 * h ** 2
        A[2*n + i][4 * i + 5] = (-1)
        b[2*n + i] = float(0)

    for i in range((n - 1)):
        A[2*n + (n-1) + i][4*i + 2] = float(2)
        A[2*n + (n-1) + i][4*i + 3] = 6*h
        A[2*n + (n-1) + i][4 * i + 6] = -2
        b[2*n + (n-1) + i] = float(0)

    A[2*n + (n-1) + i + 1][2] = float(1)
    A[2*n + (n-1) + i + 2][4*n-2] = float(2)
    A[2*n + (n-1) + i + 2][4*n - 1] = 6*h

    vect_x = pivotingLU(A, b)

    return vect_x


def getSplineInterpolationValues(x, y, full_x_series):
    
    vect = cubicSplineInterpolation(x, y)
    results_y = []
    result_x = []
    number_of_intervals = len(x)-1

    for i in range(number_of_intervals):

        start = full_x_series[full_x_series.index(x[i])]
        stop = full_x_series[full_x_series.index(x[i+1])]
        sub_interval = np.arange(start, stop+1, step=1 )
        #print(sub_interval)
        #number_of_points_between_interpolated_nodes
        #start = full_x_series.index(x[i])
        #stop = full_x_series.index(x[i+1])
        #sub_interval = full_x_series[start:stop]
        #ic(full_x_series[start], full_x_series[stop])
        #ic(len(sub_interval))
        for element in sub_interval:
            #below line can be deleted if the arange/linspace func would exclude the edge points 
            if float(element) in full_x_series and element not in result_x:
                ind = i*4
                a0, b0, c0, d0 = vect[ind], vect[ind+1], vect[ind+2], vect[ind+3]
                h = float(element - start)
                results_y.append(a0 + b0 * h + c0*(h ** 2) + d0*(h ** 3))
                result_x.append(element)

    return result_x, results_y
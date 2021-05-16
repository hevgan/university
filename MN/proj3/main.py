from funcs import *

if __name__ == "__main__":
    sizes = [6, 8, 10, 12, 14, 16, 18, 20, 22,
             24, 26, 28, 30, 32, 34, 36, 38, 40, 42]
    #sizes = np.linspace(6,25, 20)
    #sizes = map(lambda k: int(k), sizes)
    for profile in elevation_profiles:
        x, y = loadTerraindata(profile)
        for ind, point_count in enumerate(sizes):
            print(point_count, profile)
            data_length = len(x)

            #point_count = point_count+1 if point_count % 2 else point_count

            chosen_x, chosen_y, chosen_points = getEvenlyDistributedPoints(
                x, y, point_count)

            lagrange_x, lagrange_y = getLagrangeInterpolationValues(
                chosen_x, chosen_y, point_count, x)

            splines_x, splines_y = getSplineInterpolationValues(
                chosen_x, chosen_y, x)


            assert(int(x[-1]) == int(lagrange_x[-1]) == int(splines_x[-1]) )
            assert len(splines_x) == len(splines_y) == len(lagrange_x) == len(lagrange_y) == len(x) == len(y)
            assert list(splines_x) == list(x) == list(lagrange_x)
            displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x, splines_y, profile, point_count, ind, interpolationPlotType.both)

            for val, type in enumerate(interpolationPlotType):
                ...
                #displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x, splines_y, profile, point_count, ind, type)


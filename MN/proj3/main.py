from funcs import *

if __name__ == "__main__":
    sizes = [6, 8, 10, 12, 14, 16, 18, 20, 22,
             24, 26, 28, 30, 32, 34, 36, 38, 40, 42]
    for profile in elevation_profiles:
        x, y = loadTerraindata(profile)
        for ind, point_count in enumerate(sizes):
            print(point_count, profile)
            data_length = len(x)

            point_count = point_count+1 if point_count % 2 else point_count

            chosen_x, chosen_y, chosen_points = getEvenlyDistributedPoints(
                x, y, point_count)

            lagrange_x, lagrange_y = getLagrangeInterpolationValues(
                chosen_x, chosen_y, point_count, data_length)

            splines_x, splines_y = getSplineInterpolationValues(
                chosen_x, chosen_y, point_count)

            displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x,
                               splines_y, profile, point_count, ind, interpolationPlotType.both)
            displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x,
                               splines_y, profile, point_count, ind, interpolationPlotType.splines)
            displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x,
                               splines_y, profile, point_count, ind, interpolationPlotType.lagrange)

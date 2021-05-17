from funcs import *

def main():

    sizes = np.arange(6, 20, step = 2)

    for profile in elevation_profiles:

        x, y = loadTerraindata(profile)

        for ind, point_count in enumerate(sizes):

            print('terrain: ',profile, ' \t', 'points: ', point_count)

            chosen_x, chosen_y, chosen_points = getEvenlyDistributedPoints(
                x, y, point_count)

            lagrange_x, lagrange_y = getLagrangeInterpolationValues(
                chosen_x, chosen_y, point_count, x)

            splines_x, splines_y = getSplineInterpolationValues(
                chosen_x, chosen_y, x)

            assert(int(x[-1]) == int(lagrange_x[-1]) == int(splines_x[-1]) )
            assert len(splines_x) == len(splines_y) == len(lagrange_x) == len(lagrange_y) == len(x) == len(y)
            assert list(splines_x) == list(x) == list(lagrange_x)

            for val, type in enumerate(interpolationPlotType):
                displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x, splines_y, profile, point_count, ind, type)

            # difference_lagrange = np.subtract(y, lagrange_y)
            # difference_splines = np.subtract(y, splines_y)
            # cumsum_lagrange = np.cumsum(difference_lagrange)
            # cumsum_splines = np.cumsum(difference_splines)
            # max_diff_lagrange = np.max(difference_lagrange)
            # max_diff_splines = np.max(difference_splines)

            # print(cumsum_lagrange[-1], cumsum_splines[-1], max_diff_lagrange, max_diff_splines)
            
            

if __name__ == "__main__":
   main()

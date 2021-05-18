from funcs import *

def main():

    max_points = 30
    sizes = np.arange(6, max_points+1, step = 2)
    errors = [{'num_of_pts': i,'lagrange_RMS': [], 'splines_RMS': []} for i in sizes] 

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

            tmp_error_lagrange = RMS(y, lagrange_y)
            tmp_error_splines = RMS(y, splines_y)

            errors[ind]['lagrange_RMS'] = tmp_error_lagrange
            errors[ind]['splines_RMS'] = tmp_error_splines

            print(errors[ind])

            for val, type in enumerate(interpolationPlotType):
                displayAquiredData(x, y, chosen_x, chosen_y,  lagrange_x, lagrange_y, splines_x, splines_y, profile, point_count, ind, type)
            
            

if __name__ == "__main__":
   main()

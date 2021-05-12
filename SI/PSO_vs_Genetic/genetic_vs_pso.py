import numpy as np
import matplotlib.pyplot as plt
import operator
from mpl_toolkits.mplot3d import Axes3D

population_size = 10
np.random.seed(175854)

max_iters = 60
# initial setting for PSO
w = 0.7  # inertia

# initial settings genetic
world_scale = 10
min_x = -1*world_scale
max_x = 1*world_scale
min_y = -1*world_scale
max_y = 1*world_scale
max_dst_for_genetic = np.sqrt(world_scale)
breeders_count = population_size-1
mutation_rate = 0.1
elite_count = 2



precision = 50
wait_time = 0.1

def moveSwarm(swarm):
    swarm = sortFitness(swarm)
    best = swarm[0]
    for i in range(1, len(swarm)):
        x_best, y_best = best['x'], best['y']
        x_curr, y_curr = swarm[i]['x'], swarm[i]['y']
        distance = {'x': x_best - x_curr, 'y': y_best - y_curr}
        norm = np.sqrt(distance['x']**2 + distance['y']**2)
        direction = {'x': distance['x']/norm, 'y': distance['y']/norm}
        swarm[i]['x'] += w * direction['x']
        swarm[i]['y'] += w * direction['y'] 
        swarm[i]['z'] = fitness(swarm[i]['x'], swarm[i]['y'])
  

    return swarm

# sorting according to increasing value
def sortFitness(population):
    return sorted(population, key=lambda k: k['z'], reverse=True)

# creating a new generation
def newGeneration(population):
    population = selection(population)
    population = crossover(population)
    population = mutation(population)
    return population

# selecting the best fitted specimens
def selection(population):
    population = sortFitness(population)
    return population[:int(breeders_count)]

# breeding the best specimens
def crossover(old_population):
    old_population = sortFitness(old_population)
    parents = old_population[:breeders_count]
    population = []
    [population.append(old_population[i]) for i in range(elite_count)]
    while(len(population) < population_size):
        p1 = np.random.choice(parents)
        p2 = np.random.choice(parents)
        if (p1 == p2):
            continue
        else:
            child = {'x': (p1['x']+p2['x'])/2.0,'y': (p1['y']+p2['y'])/2.0, 'z': None}
            child['z'] = function(child['x'], child['y'])
            population.append(child)
    return population

# randomly mutating genomes
def mutation(population):

    offset_x = 0
    offset_y = 0
    for i in range(len(population)):
        if (np.random.uniform(0, 1) < mutation_rate):
            offset_x += np.random.uniform(-max_dst_for_genetic,max_dst_for_genetic)
            offset_y += np.random.uniform(-max_dst_for_genetic,max_dst_for_genetic)
            # excluding the current leader
            mutating_no = np.random.choice(range(1, len(population)))
            population[mutating_no]['x'] += offset_x
            population[mutating_no]['y'] += offset_y
            population[mutating_no]['z'] = fitness(population[mutating_no]['x'], population[mutating_no]['y'])
    return population


# terrain generation
def function(x, y):
    return np.cos(x)*np.cos(y)*np.exp(-np.sqrt(x**2 + y**2)/4)

# fitness calculation
def fitness(x, y):
    return function(x,y)


# plot and fuction settings
fig = plt.figure(figsize=(10, 7))
ax = plt.axes(projection="3d")
x = np.linspace(min_x, max_x, num=precision)
y = np.linspace(min_y, max_y, num=precision)
X, Y = np.meshgrid(x, y)
Z = function(X, Y)
ax.plot_surface(X, Y, Z, rstride=1, cstride=1,
                cmap='winter', edgecolor='none', alpha=0.3)
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
plt.xlim(min_x, max_x)
plt.ylim(min_y, max_y)
#plt.zlim(min_y, max_y) #get max vals from func and plot it accordingly TODO



# population placement generation [genetic]
coords_GEN = [{'x': np.random.uniform(min_x, max_x), 'y': np.random.uniform(
    min_y, max_y)} for _ in range(population_size)]
points_GEN = [{'x': coords_GEN[i]['x'], 'y': coords_GEN[i]['y'], 'z': function(
    coords_GEN[i]['x'], coords_GEN[i]['y'])} for i in range(len(coords_GEN))]

# population placement generation [PSO]
coords_PSO = [{'x': np.random.uniform(min_x, max_x), 'y': np.random.uniform(
    min_y, max_y)} for _ in range(population_size)]
points_PSO = [{'x': coords_PSO[i]['x'], 'y': coords_PSO[i]['y'], 'z': function(
    coords_PSO[i]['x'], coords_PSO[i]['y'])} for i in range(len(coords_PSO))]


best_genetic = []
best_swarm = []

iteration_no = 0
# symulation
while(iteration_no < max_iters ):
    iteration_no+=1
    plt.title(f'iteration no. {iteration_no}')
    print(f'iteration: {iteration_no}')
    # GENETIC
    points_GEN = newGeneration(points_GEN)
    best_genetic.append(1-points_GEN[0]['z'])

    x_s = [point['x'] for point in points_GEN]
    y_s = [point['y'] for point in points_GEN]
    z_s = [point['z'] for point in points_GEN]
    plotted_points = ax.scatter(x_s, y_s, z_s, color='red', s=40, alpha=1.0, label='genetic')

    # PSO
    points_PSO = moveSwarm(points_PSO)
    best_swarm.append(1-points_PSO[0]['z'])

    x_s_PSO = [point['x'] for point in points_PSO]
    y_s_PSO = [point['y'] for point in points_PSO]
    z_s_PSO = [point['z'] for point in points_PSO]
    plotted_points_PSO = ax.scatter(x_s_PSO, y_s_PSO, z_s_PSO, color='green', s=40, alpha=1.0, label='swarm')
    
    plt.pause(wait_time)
    plt.legend(['terrain' , 'genetic', 'swarm'])
    plotted_points.remove()
    plotted_points_PSO.remove()
else:
    plotted_points = ax.scatter(x_s, y_s, z_s, color='red', s=40, alpha=1.0, label='genetic')
    plotted_points_PSO = ax.scatter(    x_s_PSO, y_s_PSO, z_s_PSO, color='green', s=40, alpha=1.0, label='swarm')
    plt.legend(['terrain' , 'genetic', 'swarm'])
plt.show()
fig.savefig("3D_plot.png")

# chart plot
fig = plt.figure(figsize=(10, 7))
plt.title('dist from max func value per iteration')
plt.xlabel('iteration no.')
plt.ylabel('value')
plt.plot(best_genetic, color='red', label='genetic')
plt.scatter(range(len(best_genetic)),best_genetic, color='red')
plt.plot(best_swarm, color='green', label='swarm')
plt.scatter(range(len(best_swarm)),best_swarm, color='green')
plt.legend()
plt.show()
fig.savefig("convergence_comparision.png")

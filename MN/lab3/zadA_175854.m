Index = 175854;
N0 = mod(Index, 10);
N1 = mod(N0-1,4)+1;
N1
N = 10;
density = 3; 
[Edges] = generate_network(N, density);
disp(Edges)


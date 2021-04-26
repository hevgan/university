clc
clear all
close all

x = [500, 1000, 3000, 6000, 12000];
time = sparse(zeros(length(x)));
d = 0.85;
density = 10; 

for j=1:length(x)
     
    N = x(j);
    [Edges] = generate_network(N, density);
    A = sparse(zeros(1, N));  
    B = sparse(zeros(N, N));
    I = speye(N);
    
    for i = 1:N
        A(i) = 1/sum(B(:,i));
    end
      
    A = diag(A);
    A = sparse(A);
    b = ((1-d)/N) + zeros(1,N);
    M = I - d * B * A;
    tic;
    r = M/b;    
    time(j) = toc;
end

figure('Position', [100, 100, 800, 800]);
plot(x,time);
title("execution time for direct division method in relation to the size of a matrix");
ylabel("time of execution [s]");
xlabel("matrix size");
saveas(gcf, 'plots/zadD_175854.png');



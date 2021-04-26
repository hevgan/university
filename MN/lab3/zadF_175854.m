clc
clear all
close all
plotsize = 1000;
x = [500, 1000, 3000, 6000, 12000];

density = 10;
d = 0.85;
precision = 10^(-14); 
sparse_time_start = 0; %for sparse matrices
full_time_start = 0; %for full matrices

sparse_time_start = tic;


for j = 1:length(x)
    N = x(j);
    [Edges] = generate_network(N, density);
    I = speye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
    A = sparse(zeros(1, N)); 
    
    for i = 1:N
        A(i) = 1/sum(B(:,i));
    end
    
    A = diag(A);
    b = ((1-d)/N) + zeros(N,1);
    M = I - d*B*A;

    r = ones(N, 1);
    D = diag(diag(M));
    U = triu(M, 1);
    L = tril(M, -1);
    sparse_iterations(j) = 0;

    
    res = Inf;
tic
    while(norm(res) > precision)
        sparse_iterations(j) = sparse_iterations(j) + 1;

         r = - (D+L)\(U*r) + (D+L)\b;
        res = M*r - b;
            show_progress(res, N, 'sparse');

        residuum(j, sparse_iterations(j)) = norm(res);
    end

    sparse_time(j) = toc;
    disp(sparse_time(j));


end

%time for sparse
figure('Position', [100, 100, plotsize, plotsize]);
plot(x,sparse_time);
title("execution time in relation to matrix size");
subtitle("for sparse formats (for Gauss-Seidel method)");
ylabel("time [s]");
xlabel("matrix size");
saveas(gcf, 'plots/zadF_175854_sparse.png');


%full ones
for j = 1:length(x)
    N = x(j);
    [Edges] = generate_network(N, density);
    I = eye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
    B = full(B);
    A = full(zeros(1, N)); 
    
    for i = 1:N
        A(i) = 1/sum(B(:,i));
    end
    
    A = diag(A);
    

    
    b = ((1-d)/N) + zeros(N,1);
    M = I - d*B*A;

    r = ones(N, 1);
    D = diag(diag(M));
    U = triu(M, 1);
    L = tril(M, -1);

    tic
    res = Inf;

    while(norm(res) > precision)
        r = - (D+L)\(U*r) + (D+L)\b;
        res = M*r - b;
        show_progress(res, N, 'full');
        
    end

    full_time(j) = toc;
    disp(full_time(j));


end

%time for sparse
figure('Position', [100, 100, plotsize, plotsize]);
plot(x,full_time);
title("execution time in relation to matrix size");
subtitle("for full formats (for Gauss-Seidel method)");
ylabel("time [s]");
xlabel("matrix size");
saveas(gcf, 'plots/zadF_175854_full.png');



%sparse/full time plot
iloraz = sparse_time./full_time;
plot(x, iloraz);
title("relation between sparse matrix time execution and full format matrix time exectution");
subtitle("in corelation to matrix size (for Gauss-Seidel method)");
ylabel("t_1/t_2 (sparse time divided by full time)");
xlabel("matrix size");
saveas(gcf, 'plots/zadF_175854_time_execution_relation.png');




%1
figure('Position', [100, 100, plotsize, plotsize]);
plot(x, sparse_time)
title("execution time in relation to matrix size");
subtitle("for Gauss-Seidel method, sparse matrices");
ylabel("time [s]");
xlabel("matrix size");
saveas(gcf, 'plots/zadF_175854_1.png');

%2
figure('Position', [100, 100, plotsize, plotsize]);
plot(x, sparse_iterations)
title("iteration count in relation to matrix size");
subtitle("for Gauss-Seidel method, sparse matrices");
ylabel("iteration count");
xlabel("matrix size");
saveas(gcf, 'plots/zadF_175854_2.png');

%3
figure('Position', [100, 100, plotsize, plotsize]);
semilogy(residuum(2, :));
title(strcat('Residuum norm for size = ', string(x(2))))
subtitle("for Gauss-Seidel method, sparse matrices");
ylabel("residuum norm");
xlabel("no. iteration");
saveas(gcf, 'plots/zadF_175854_3.png');


%dodatek
figure('Position', [100, 100, plotsize, plotsize]);
subplot(length(x),1,1)
sgtitle( strcat('Residuum norms for sizes=', strjoin(string(x), ', '), ' for Gauss-Seidel method, sparse matrices') )
for idx=1:length(x)
    subplot(length(x),1,idx)
    semilogy(residuum(idx, :));
    title(strcat('size = ', string(x(idx))))
    ylabel("residuum norm");
    xlabel("no. iteration");

end
saveas(gcf, 'plots/zadF_175854_3+.png');





        
        
        
function show_progress(res, N, type)

        clc
        fprintf(strcat('norm(res) = ', string(norm(res)) , ' for N = ', string(N), 'type = ', type ));
        fprintf(newline);

end

clc
clear all
close all

x = [500, 1000, 3000, 6000, 12000];
density = 10;
d = 0.85;
precision = 10^(-14); 


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
  iterations(j) = 0;

  
  res = Inf;
  tic
  while(norm(res) > precision)
    r = -(D\(L+U))*r + D\b;
    res = M*r - b;
    
    iterations(j) =  iterations(j) +1;
    residuum(j, iterations(j)) = norm(res);

    end

  time(j) = toc;
      disp(time(j));

end

%1
figure('Position', [100, 100, 1000, 1000]);
plot(x, time)
title("execution time in relation to matrix size");
subtitle("for Jacobi method, sparse matrix formats");
ylabel("time [s]");
xlabel("matrix size");
saveas(gcf, 'plots/zadE_175854_1.png');

%2
figure('Position', [100, 100, 1000, 1000]);
plot(x, iterations)
title("iteration count in relation to matrix size");
subtitle("for Jacobi method, sparse matrix formats");
ylabel("iteration count");
xlabel("matrix size");
saveas(gcf, 'plots/zadE_175854_2.png');


%3    
figure('Position', [100, 100, 1000, 1000]);
    semilogy(residuum(2, :));
    title(strcat('Residuum norm for size = ', string(x(2))))
    subtitle("for Jacobi method, sparse matrix formats");
    ylabel("residuum norm");
    xlabel("no. iteration");
    saveas(gcf, 'plots/zadE_175854_3.png');


%dodatek
figure('Position', [100, 100, 1000, 1000]);
subplot(length(x),1,1)
sgtitle( strcat('Residuum norms for sizes=', strjoin(string(x), ', '), ' for Jacobi method, sparse formats') )
for idx=1:length(x)
    subplot(length(x),1,idx)
    semilogy(residuum(idx, :));
    title(strcat('size = ', string(x(idx))))
    ylabel("residuum norm");
    xlabel("no. iteration");
    
end
    saveas(gcf, 'plots/zadE_175854_3+.png');
    

    

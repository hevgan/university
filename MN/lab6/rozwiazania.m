clc 
clear all
close all

Index = 175854;
N0 = mod(Index,10);
N1 = mod(N0-1,4)+1;

x0=10;
y0=10;
width=1000;
height=1000
set(gcf,'position',[x0,y0,width,height])

%2
load trajektoria1.mat

plot3(x,y,z,'o');
grid on;
axis equal;
title("rzeczywista trajektoria lotu drona");
xlabel("x");
ylabel("y");
zlabel("z");
exportgraphics(gcf,'./plots/175854_Adryan_zad2.png','Resolution',300);

%3

%[~, xa5] = aproksymacjaWielFix(n,x,N);
%[~, ya5] = aproksymacjaWielFix(n,y,N);
%[wsp, za5] = aproksymacjaWielFix(n,z,N);
%plot3(xa5,ya5,za5,'LineWidth',4, 'color', 'black');
%f5 = gcf;
%exportgraphics(f5,'./plots/175854_Adryan_zad5_after.png','Resolution',300);

%4 
N = 50;

[~, xa] = aproksymacjaWiel(n,x,N);
[~, ya] = aproksymacjaWiel(n,y,N);
[~, za] = aproksymacjaWiel(n,z,N);

hold on
plot3(x,y,z,'o', 'color', 'blue');
plot3(xa,ya,za,'LineWidth',4, 'color', 'black');
grid on;
axis equal;
title("trajektoria rzeczywista i jej aproksymacja wielomianowa (N=50)");
xlabel("x");
ylabel("y");
zlabel("z");
hold off;

exportgraphics(gcf,'./plots/175854_Adryan_zad4.png','Resolution',300);


%5

load trajektoria2.mat
N = 62; %rozwianiem jest zmiana N na wartość N mniejsza od 16.

subplot(2,1,1);
plot3(x,y,z,'LineWidth',2, 'color', 'black');
title("aproksymacja dla N=15"); %dla poprawionego
xlabel("x");
ylabel("y");
zlabel("z");
grid on;
axis equal;

[~, xa5] = aproksymacjaWiel(n,x,N);
[~, ya5] = aproksymacjaWiel(n,y,N);
[~, za5] = aproksymacjaWiel(n,z,N);
subplot(2,1,2);

plot3(xa5,ya5,za5,'LineWidth',2, 'color', 'black');
title("aproksymacja z widocznym efektem Rungego dla N=62");
xlabel("x");
ylabel("y");
zlabel("z");
axis equal;
grid on;

exportgraphics(gcf,'./plots/175854_Adryan_zad5.png','Resolution',300);

hold off
subplot(1,1,1);

err = []
M = length(n);

for N =1:N
    [~, xtmp] = aproksymacjaWiel(n, x, N);
    [~, ytmp] = aproksymacjaWiel(n, y, N);
    [~, ztmp] = aproksymacjaWiel(n, z, N);
    
    calculated = (sqrt(sum((x - xtmp).^2)) / M) + (sqrt(sum((y - ytmp).^2)) / M) + (sqrt(sum((z - ztmp).^2)) / M);
    err = [err, calculated];
end

semilogy(err);
grid on;
title("błąd aproksymacji wielomianowej (N=62)");
xlabel("N");
ylabel("wartość błędu");
exportgraphics(gcf,'./plots/175854_Adryan_zad5_b.png','Resolution',300);

%6 

[xt] = aprox_tryg(n,x,N);
[yt] = aprox_tryg(n,y,N);
[zt] = aprox_tryg(n,z,N);

hold off;
plot3(x,y,z,'o', 'color', 'blue');
hold on

plot3(xt,yt,zt,'LineWidth',4, 'color', 'black');
grid on;
axis equal;
title("trajektoria rzeczywista i jej aproksymacja trygonometryczna (N=62)");
xlabel("x");
ylabel("y");
zlabel("z");
hold off;
exportgraphics(gcf,'./plots/175854_Adryan_zad7.png','Resolution',300);

err = [];
M = length(n);

for N =1:N
    [xtmp] = aprox_tryg(n, x, N);
    [ytmp] = aprox_tryg(n, y, N);
    [ztmp] = aprox_tryg(n, z, N);
    
    calculated = (sqrt(sum((x - xtmp).^2)) / M) + (sqrt(sum((y - ytmp).^2)) / M) + (sqrt(sum((z - ztmp).^2)) / M);
    err = [err, calculated];
end

semilogy(err);
grid on;
title("błąd aproksymacji trygonometrycznej (N=62)");
xlabel("N");
ylabel("wartość błędu");
exportgraphics(gcf,'./plots/175854_Adryan_zad7_b.png','Resolution',300);

%wyszukiwanie zadowalającej aproksymacji

err = [];
M = length(n);
best_N = 0;

%zadany epsilon
eps = 10^-3;

for N =1:N
    [xtmp] = aprox_tryg(n, x, N);
    [ytmp] = aprox_tryg(n, y, N);
    [ztmp] = aprox_tryg(n, z, N);
    
    calculated = (sqrt(sum((x - xtmp).^2)) / M) + (sqrt(sum((y - ytmp).^2)) / M) + (sqrt(sum((z - ztmp).^2)) / M);
    err = [err, calculated];
    
    if calculated <= eps
        fprintf('satisfying epsilon has been found!')
        best_N = N;
        break;
    end
end

if (best_N == 0)
     [tmp, best_N] = min(err);
     fprintf(strcat('satisfying epsilon= ',eps ,' has not been found!'));

end

fprintf(strcat('best approximation is for N= ', string(best_N), ' the value is = ', string(err(best_N))));

    
    




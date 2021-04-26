clc
clear all
close all

% odpowiednie fragmenty kodu mo�na wykona� poprzez znazaczenie i wci�ni�cie F9
% komentowanie/ odkomentowywanie: ctrl+r / ctrl+t

% Zadanie A
%------------------
N = 10;
density = 3; % parametr decyduj�cy o gestosci polaczen miedzy stronami
[Edges] = generate_network(N, density);
%-----------------

% Zadanie B
%------------------
% generacja macierzy I, A, B i wektora b
% ...
A = sparse(A);  % macierze A, B i I musz� by� przechowywane w formacie sparse (rzadkim)
B = sparse(B);
I = sparse(I);

save zadB_indeks A B I b
%-----------------



% Zadanie D
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];


for i = 1:5
tic
% obliczenia
czas_Gauss(i) = toc;
end

plot(N, czas_Gauss)
%------------------



% Zadanie E
%------------------
clc
clear all
close all

% przyk�ad dzia�ania funkcji tril, triu, diag:
% Z = rand(4,4)
% tril(Z,-1) 
% triu(Z,1) 
% diag(diag(Z))


for i = 1:5
tic
% obliczenia
czas_Jacobi(i) = toc;
end

plot(N, czas_Jacobi)
%------------------









A = sparse(zeros(1, N)); 
B = sparse(zeros(N, N));
I = speye(N);

for i = 1:N
    A(i) = 1/sum(B(:,i));
end

A = diag(A);
d = 0.85;
b = ((1-d)/N) + zeros(1,N);

save zadB_175854 A B I b
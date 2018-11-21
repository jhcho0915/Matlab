% Gram-Schmidt Orthogonolization
%

function [Q,R] = GramSchmidt(A,p)
[m,n] = size(A);
Q = zeros(m,m);
R = zeros(m,n);

for j = 1:m
    v = A(:,j); % v begins as column j of A
    for i = 1: j-1
        R(i,j)=Q(:,i)'*v;
        v = v-R(i,j)*Q(:,i);
    end
    R(j,j) = norm(v);
    Q(:,j) = v/R(j,j);
end
R = R(:,1:p);
end

%[Q,R]=qr(A); % compute full QR factorization


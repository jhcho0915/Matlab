function [A,B] = triangularize(A,b)
[m,n] = size(A);

for i=1:n-1
    for j = i+1:n
        q = (A(j+1)/A(i,i));
        A(j,:) = A(j,:) - q*(A(i,:));
        b(j) = b(j) - q*(b(i));
    end
end
end
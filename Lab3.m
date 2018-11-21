% MATH 413: Lab 3
% Jae H. Cho
% September 28, 2018

%% Problem 1: LU Decomposition
%
a = (sqrt(2))/2;
A = [a 0 0 -1 -a 0 0 0 0 0 0 0 0
    0 1 0 0 0 -1 0 0 0 0 0 0 0
    0 0 1 0 0 0 0 0 0 0 0 0 0
    0 0 0 1 0 0 0 -1 0 0 0 0 0
    a 0 1 0 a 0 0 0 0 0 0 0 0
    0 0 0 0 a 1 0 0 -a -1 0 0 0 
    0 0 0 0 0 0 1 0 0 0 0 0 0
    0 0 0 0 0 0 0 1 a 0 0 -a 0
    0 0 0 0 a 0 1 0 a 0 0 0 0
    0 0 0 0 0 0 0 0 0 1 0 0 -1
    0 0 0 0 0 0 0 0 0 0 1 0 0
    0 0 0 0 0 0 0 0 a 0 1 a 0
    0 0 0 0 0 0 0 0 0 0 0 a 1];

b = [0; 0; 10; 0; 0; 0; 0; 0; 15; 0; 20; 0; 0];

% function [L,U] = my_ludecomp(A)
% n = size(A, 2); 
% I = eye(n); O = zeros(n);
% L = I; U = O;

% for m = 1:n
% if m == 1
    % v(m:n) = A(m:n,m);
%else
    % z = L(1:m-1,1:m-1)\A(1:m-1,m);
    % U(1:m-1,m) = z;
    % v(m:n) = A(m:n,m)-L(m:n,1:m-1)*z;
% end
% if m < n, L(m+1:n,m) = v(m+1:n)/v(m); 
% end
% U(m,m) = v(m);
% end
% end

disp("The L and U matrices output the following: ")
[L,U] = my_ludecomp(A)


%% Problem 1: Forward Substitution
%
% function [y] = my_forwsub(L,b)
%
% n = size(L,2);
% for i = 1:n
    % ly(i) = b(i);
    % for j = 1:i-1
        % ly(i) = ly(i) - L(i,j)*ly(j);
    % end
% end
% y = ly';
% end
%

disp("By implementing forward back substitution, our results show: ")
[y] = my_forwsub(L,b)


%% Problem 1: Backward Substitution

% function x = my_backsubs(U,y)
%
% n = size(U,2);
% for i = n:-1:1
   % lx(i) = y(i);
   % for j = i+1:n
      % lx(i) = lx(i) - U(i,j)*lx(j);
   % end
   % lx(i) = lx(i)/U(i,i);
% end
% x = lx';
% end

disp("By solving the systems of equations, the vector f of member forces is ")
[x] = my_backsubs(U,y)

%% Problem 2: Ohm's Law

% node analysis of r.
r12 = 12;
r13 = 13;
r14 = 14;
r20 = 20;
r23 = 23;
r25 = 25;
r34 = 34;
r35 = 35;
r45 = 45;

% R matrix
R = [r25+r12+r14+r45 -r12 -r14 -r45;
    -r12 r23+r12+r13 -r13 0;
    -r14 -r13 r14+r13+r34 -r34;
    -r45 0 -r34 r35+r45+r34];

% Voltage source 
vs = 6;

b1 = [0;0;0;vs];

[L,U] = my_ludecomp(R);

[y] = my_forwsub(L,b1);

disp("The current vector is ")
[i] = my_backsubs(U,y)

% node analaysis of g. 
g12 = 1/12;
g13 = 1/13;
g14 = 1/14;
g20 = 1/20;
g23 = 1/23;
g24 = 1/24;
g25 = 1/25;
g34 = 1/34;
g35 = 1/35;
g45 = 1/45;

% G matrix
G = [g12+g13+g14 -g12 -g13 -g14;
    -g12 g12+g23+g25 -g23 0;
    -g13 -g23 g13+g23+g24+g35 -g34;
    -g14 0 -g34 g14+g34+g45];

c = [0;0;g35*vs;0];

[L,U] = my_ludecomp(G);

[y] = my_forwsub(L,c);

disp("The voltage vector is ")
[v] = my_backsubs(U,y)

%Ohm's Law
V = R * i

%% functions
%
% LU Decomposition Function
%
function [L,U] = my_ludecomp(A)

n = size(A, 2); 
I = eye(n); O = zeros(n);
L = I; U = O;

for m = 1:n
if m == 1
    v(m:n) = A(m:n,m);
else
    z = L(1:m-1,1:m-1)\A(1:m-1,m);
    U(1:m-1,m) = z;
    v(m:n) = A(m:n,m)-L(m:n,1:m-1)*z;
end
if m < n, L(m+1:n,m) = v(m+1:n)/v(m); 
end
U(m,m) = v(m);
end
end


% Forward Back Substitution Function
%
function [y] = my_forwsub(L,b)
n = size(L,2);
for i = 1:n
    ly(i) = b(i);
    for j = 1:i-1
        ly(i) = ly(i) - L(i,j)*ly(j);
    end
end
y = ly';
end


% Backward Back Substitution Function
%
function x = my_backsubs(U,y)
n = size(U,2);
for i = n:-1:1
   lx(i) = y(i);
   for j = i+1:n
      lx(i) = lx(i) - U(i,j)*lx(j);
   end
   lx(i) = lx(i)/U(i,i);
end
x = lx';
end
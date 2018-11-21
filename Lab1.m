%Lab 1
%Jae H. Cho
%September 6, 2018
%
%Remarks:

%Problem 1: Use z = randi(20)????? for simplicity.
%Problem 4: Do not forget to comment on what does the loop do and when does it terminate. (-0.5)
%Problem 5: Please solve the equation via the backslash operator.  Also please note that inverse = transpose is only true for orthogonal matrices and not always applicable. (-1) 

clear all


%% problem 1

%Assign variables to corresponding values/equations
w = 5;
x = sqrt(2);
y = 4^3;
z = int16(1 + (20-1)*rand(1,1)) %randomly generate an integer from 1,20
a = x*y*z;
b = (w+y)/(x+z);

%% problem 2

g = 1 + (100-1)*rand(1,1);
if g > 50
    g = g/2;
else
    g = g*2;
end

%% problem 3

x = 10;
while x > 0
    x = x/2;
end

%Yes, this loop will terminate with the result x = 0. The result should not
%be 0, because when running through this mathemtatical problem, one ought
%to know that the quotient of two numbers can only result int the value 0
%when the numerator is 0. 


%% problem 4

x = [1,2,3];
while sum(x<20)
    x(:,1) = x(:,2);
    x(2)=[];
    x(3) = sum(x);
end

%% problem 5

A = zeros(3,3);
A(:,1) = [1,2,3];
A(:,2) = [2,-1,0];
A(:,3) = [3,1,-1];

b = [9; 8; 3];

x5 = A\b;
%x5 = A' * b; % Properties of transpose matrices

%% problem 6

%test samples for matrrices function
A = [1,2,3; 4,5,6; 7,8,9]
B = [0,1,5; 5,8,3; 0,-1,4]

[A,B] = matrices(A,B)

%function [A,B] = matrices(A,B)
    %a = B(end,:);
    %b = A(end,:);
    %A(end,:) = a;
    %B(end,:) = b;
%end

%% problem 7

%test samples for vector transformation function
data = [-1, 0, 3, 5, 6, 8, 7, 8, 11];
minval = 5;

[newdata] = PS1_Q7(data, minval);

%function [newdata] = PS1_Q7(data, minval)
    %newdata = data;
    %newdata(data < minval) = data(data < minval)*2
%end

%% problem 8

x = [0:0.01:10];
y = sin(x);
plot(x,y)
title('Graph of x and sin(x)')
xlabel('Input Values')
ylabel('Output Values')

%% problem 9

x = [0:0.01:10];
y = sin(x);

z = cos(x);
plot(x,y, x,z, '--')
legend ("sin(x)","cos(x),")
title('Graph of sin(x) and cos(x)')
xlabel('Input Values')
ylabel('Output Values')

%% problem 10

x = linspace(-3,3);
y = x;
[X,Y] = meshgrid(x,y)

%The command meshgrid "transforms the domain specified by vectors x and y 
%into arrays X and Y , which can then be used to evaluate functions of two 
%variables and three-dimensional mesh/surface plots."

%3D Gaussian equation
Z = (1000/sqrt(2*pi)) * exp(((-X.^2)/2)-((Y.^2)/2));

surf(X,Y,Z)
shading interp
title('3D Gaussian')

%% functions

function [A,B] = matrices(A,B)
    a = B(end,:);
    b = A(end,:);
    A(end,:) = a;
    B(end,:) = b;
end



function [newdata] = PS1_Q7(data, minval)
    newdata = data;
    newdata(data < minval) = data(data < minval)*2;
end



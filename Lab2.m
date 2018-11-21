% MATH 413: Lab 2
% Jae H. Cho
% September 21, 2018

clear all

%% problem 1

f = @(x)(4*pi)*(100-(x-10).^2);
f2 = @(x) integral(f, 0, x) - 5000;

a = 0;
b = 20;

% Bisection Function

% function [root,count] = mybisection(f,a,b)
% if f(a)*f(b) > 0
    % error('f(a)f(b) < 0 not true!');
% end

% count = 0;              %This is our iteration variable that initializes the count at 0.
% while (b-a)/2 > 10^(-5)
    % c = (a+b)/2;
    % if f(a)*f(c) < 0
        % b = c;
    % else
        % a = c;
    % end
    % count = count + 1;
% end
% root = (a+b)/2;
% end

[root,count] = mybisection(f2,a,b)

%% problem 2

f = @(x)(4*pi)*(100-(x-10).^2);
f2 = @(x) integral(f, 0, x) - 10000;
x0 = 14.484615325927734;

% newtons method

% function [xnew,count] = mynewtons2(f2, f, x0)
% xnew = x0 - (f2(x0))/f(x0);
% count = 0;
% while abs(x0 - xnew) > 10^(-5)
    % xnew = x0;
    % x0 = x0 - (f2(x0))/f(x0);
    % count = count + 1;
    
% end
% end

[xnew,count] = mynewtons(f2, f, x0)

%% problem 3

f = @(x)(4*pi)*(100-(x-10).^2);
f2 = @(x) integral(f, 0, x) - 7000;

a = 7.242307662963867;
b = 14.484615325927734;

% secant method

% function [root,count] = secant(f2, a, b)
% root = b - (b*f2(b) - a*f2(b))/(f2(b) - f2(a));
% count = 0;
% while abs(b-c) > 10^(-5)
    % a = b;
    % b = root;
    % root = b - (b*f2(b) - a*f2(b))/(f2(b) - f2(a));
    % count = count + 1;

% end
%end

[c,count] = mysecant(f2, a, b)

%% functions

% Problem 1: Bisection Function

%f = @(x)(4*pi)*(100-(x-10).^2);
%f2 = @(x) integral(f, 0, x) - 5000;

function [root,count] = mybisection(f,a,b)
if f(a)*f(b) > 0
    error('f(a)f(b) < 0 not true!');
end

count = 0;              %This is our iteration variable that initializes the count at 0.
while (b-a)/2 > 10^(-5)
    c = (a+b)/2;
    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
    count = count + 1;
end
root = (a+b)/2;
end

%Problem 2: Newton's Method Function

%f = @(x)(4*pi)*(100-(x-10).^2);
%f2 = @(x) integral(f, 0, x) - 10000;

function [xnew,count] = mynewtons(f2, f, x0)
xnew = x0 - (f2(x0))/f(x0);
%fprintf('x(0) = %10g \n', xnew)
count = 0;
while abs(x0 - xnew) > 10^(-5)
    %d = (f2(x0))/f(x0);
    %x0 = x0 - (f2(x0))/f(x0);
    xnew = x0;
    %xp = xnew;
    x0 = x0 - (f2(x0))/f(x0);
    count = count + 1;
    %fprintf('x(%i) = %10g \n', xnew)
    %if abs((f2(x0))/f(x0)) < 10^(-5)
        %fprintf('Converged! \n')
        %return
end
end


%Problem 3: Secant Method Function

%f = @(x)(4*pi)*(100-(x-10).^2);
%f2 = @(x) integral(f, 0, x) - 7000;

function [c,count] = mysecant(f2, a, b)
c = b - (b*f2(b) - a*f2(b))/(f2(b) - f2(a));
count = 0;
while abs(b-c) > 10^(-5)
    a = b;
    b = c;
    c = b - (b*f2(b) - a*f2(b))/(f2(b) - f2(a));
    count = count + 1;
end
end
% Lab 2 
% September, 20, 2018
% Jae H. Cho

%Bisection Function

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


    
        
        
        
    
    

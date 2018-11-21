% MATH 413: Lab 4
% Jae H. Cho
% October 26, 2018

%% Problem 1: Find US census data for the years 1920:10:2010. 
% Using Vandermonde interpolation, find the population of the US in 2020 
% using a 9-degree polynomial.
%
%
% Create the Vandermonde Matrix
%
years = (1920:10:2010);
years = (years - 1965)/45;
x = years';

y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';

n = length(x);
V_matrix = zeros(n);

V_matrix = VanderInter(x)

% When degree 9:
V_matrix = V_matrix(:,n-9:n)\y;

% Flip aray up to down
V_matrix = flipud(V_matrix);

% The predicted population when including the year 2020.
%
years = (1920:10:2020);
years = (years - 1965)/45;
x = years';

y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';

poly_Val = Horner(V_matrix,x)

% Population values:
%   p_Val =

  %106.5000
  %123.1000
  %132.1000
  %152.3000
  %180.7000
  %205.1000
  %226.5000
  %249.6000
  %282.2000
  %309.3000
  %-24.8000

% As a result, the population of the US is approximate to be -24.8000. This
% answer is an inaccurate measurement when relating to the true population 
% in the real world, as a population cannot be negative, unless we incur
% that there is a future disaster that happened to have no people living.
% We have a steady increasing population by increase in year as well.
% The data point is far off from the pattern we observe for populations as
% the year progresses on, therefore we don't see this as a plausible value 
% of the US population or most likely any large country in the world. 

%% Problem 2: Fit the data to a 4-degree polynomial instead of a 9-degree
% polynomial and find the answer for the population in 2020 again.
%
% Apply the same data as used previusly for US census year and population
years = (1920:10:2010);
years = (years - 1965)/45;
x = years';

y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';

n = length(x);
V_matrix = zeros(n);

V_matrix = VanderInter(x)
%
% Change the value of the degree to 4.
V_matrix = V_matrix(:,n-4:n)\y;
V_matrix = flipud(V_matrix);

% The predicted population when including the year 2020.
%
years = (1920:10:2020);
years = (years - 1965)/45;
x = years';

y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';

poly_Val = Horner(V_matrix,x)

%poly_Val =

  %107.9626
  %118.4906
  %135.0747
  %155.5557
  %178.3328
  %202.3635
  %227.1639
  %252.8083
  %279.9295
  %309.7185
  %343.9250

% With a degree of 4, we arrive at a 2020 US population of 343.9250. THis 
% seems more plausible as the population continues to increase in 10 year
% increments, and we can also state that as the degree of interpolated
% function decresases, it accounts for less error, most likely helping us
% to arrive at a more accurate population in the US. 

%% Problem 3: Newton?s divided difference interpolation
% Testing with Newton's divided difference function at 9th degree. 
%
%
n = length(x);

years = (1920:10:2010);
years = (years - 1965)/45;
x = years'

c = NInterp(x,y)

years = (1920:10:2020);
years = (years - 1965)/45;
z = years';

y = [106.5, 123.1, 132.1, 152.3, 180.7, 205.1, 226.5, 249.6, 282.2, 309.3]';

p_Val = Newt_div_diff(c,x,z)

%% Problem 4: Linear piecewise interpolation. With this method
% of interpolation, we draw a line between each pair of data points
%
%
% Piecewise Linear Function
%function v = piecewlinear(x1, y1, x2)
%d_val = diff(y1)./diff(x1);
%n = length(x1);
%k = ones(size(x2));
%for j = 2:n-1
    %k(x1(j) <= x2) = j;
%end
%s = x2 - x1(k);
%v = y1(k) + s.*d_val(k);
%end

%% Problem 5: Test your piecewise interpolation function on the given function
%
%
for N = [2,4,8,16,32,64,128,256,512]
    x1 = linspace(-1, 1, N);
    y1 = 1./(1+25.*x1.^2)';
end

for N = [2,4,8,16,32,64,128,256,512]
    x2 = linspace(-1, 1, 10*N);
    v = piecewlinear(x1, y1, x2);
    mx_error = max(y1) - max(v(1:10:end))
end

% The output gives the following maximum error values:
% mx_error =
    %0.0545
    
%mx_error =
    %0.0061

%mx_error =
   %-0.0091

%mx_error =
   %-0.0115

%mx_error =
   %-0.0110

%mx_error =
   %-0.0116

%mx_error =
   %-0.0119

%mx_error =
   %-0.0108

%mx_error =
   %-0.0127

%% Functions
%
%
% Function 1
% Vandermonde Pt. 1: Vandermonde Interpolation Function
%
function answer = VanderInter(x)
n = length(x);
V_matrix = zeros(n);
V_matrix(:,end) = 1;
for j = n-1:-1:1
   V_matrix(:,j) = x .* V_matrix(:,j+1);
end
answer = V_matrix;
end

% Function 2
% Vandermonde Pt. 2: Horner's Functinon
%
function poly_Val = Horner(a,z)
n = length(a);
m = length(z);
poly_Val = a(n).*ones(size(z));
for k=n-1:-1:1
    poly_Val = z.*poly_Val + a(k);
end
end

% Function 3
% Newton's Divided Differences Function
%
function p_Val = Newt_div_diff(c,x,z)
n = length(c);
p_Val = c(n)*ones(size(z));
for k=n-1:-1:1
    p_Val = (z-x(k)).*p_Val + c(k);
end
end

% Function 4
% Newton's Divided Differences Interpolation Function
%
function c = NInterp(x,y)
% The Newton polynomial interpolant.
% 
n = length(x);
for k = 1:n-1
    y(k+1:n) = (y(k+1:n)-y(k)) ./ (x(k+1:n) - x(k));
end
c = y;
end

% Function 5
%Piecewise linear interpolation
function v = piecewlinear(x1, y1, x2)
d_val = diff(y1)./diff(x1);
n = length(x1);
k = ones(size(x2));
for j = 2:n-1
    k(x1(j) <= x2) = j;
end
s = x2 - x1(k);
v = y1(k) + s.*d_val(k);
end
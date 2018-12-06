%% Lab 5: Least Squares via Gram-Schmidt QR
% Jae H. Cho
% Nov 16, 2018

% For the BuoyData matrix provided, the first column is the year, the 
% second column is the month, the third column is the day, the fourth 
% column is the hour, the fifth column is the temperature in degrees C, 
% and the sixth column is the pCO2 in uatm (micro atmospheres). There is 
% a relationship between temperature and pCO2, and we will be fitting 
% different models to temperature vs pCO2 via least squares. Consider the 
% temperature the independent variable and pCO2 the dependent variable.
%% Question 1
%
% First, try fitting a simple linear model to the data. Use your own modified Gram-Schmidt ??
% orthogonalization code to compute the full QR factorization and solve the least squares 
% problem Rx ? = d. You may use the MATLAB built-in backslash operator. Report the coefficients 
% and plot your fit line over the actual data set.

% Load the data
load BuoyData.mat

% Extract 1st column as "years" vector
year = BuoyData(:,1);

% Extract 2nd column as "month" vector
month = BuoyData(:,2);

% Extract 3rd column as "day" vector
day = BuoyData(:,3);

% Extract 4th column as "hour" vector
hour = BuoyData(:,4);

% Extract 5th column as "temperature" vector
x = BuoyData(:,5);

% Extract 6th column as "pCO2" vector
v = BuoyData(:,6);

% Set b as CO2 values, or in my case v.
b = v;

n = size(x);
A = ones(n);
A = [A,x];

% Create the identity matrix
B = eye(length(A), length(A)-2);
A = [A, B];

p = 2;
[Q,R] = GramSchmidt(A,p);

d = Q'*v;
R_hat = R(1:p,1:p);
d_hat = d(1:p);
c = R_hat \ d_hat

% The coefficents are 343.6178 and 3.2003 where in linear line notation form
% y = 343.6178 + 3.2003.*x.

E = 343.6178 + 3.2003.*x;

Residuals1 = norm(R*c - Q'*b)

%Residuals1 = 1.4022e+03

%% Problem 2
%
% Fitting Quadratic Line
%
n = size(x);
A = ones(n);
A = [A, x, x.^2];

Quad = eye(length(A), length(A)-3);
A = [A, Quad];

p = 3;
[Q,R] = GramSchmidt(A,p);


d = Q'*v;
R_hat = R(1:p,1:p);
d_hat = d(1:p);
c = R_hat \ d_hat

% The coefficents are 357.7263, -0.3796, and 0.1613 where in quadratic line 
% notation form y = 357.7263 - 0.3796*x + 0.1613.x^2.

% Plot Graphs
% Linear Plot
x_val = 2:0.1:22;
y_val = 343.6178 + 3.2003*x_val;
plot(x,v,'.')

plot(x_val,y_val)
hold on 

% Quadratic Plot
x_valq = 2:0.1:22;
y_valq = 357.7263 - 0.3796*x_valq + 0.1613*x_valq.^2;
hold on 
plot(x,v,'.')

plot(x_valq,y_valq)
hold off

title('Plot of Linear and Quadratic Lines over Temp & CO2 Data')
xlabel('Temperature') 
ylabel('CO2') 
legend({'Linear','Data', 'Quadratic'})


%% Problem 3
%
% Expected Values
E = 343.6178 + 3.2003*x;

E2 = 357.7263 -0.3796*x + 0.1613*x.^2;

% Chi-Square Calculation
Chi = sum((v - E).^2) / 2061

Chi2 = sum((v - E2).^2) / 2060

% The Chi-squared value for the linear equation = 953.9690

% The Chi-squared value for the quadratic equation = 936.3453

% To our knowledge, the lower chi-squared value indicates that the
% quadratic model's observed data fits the expected data. Since this 
% measures the distance between your actual pCO2 data point and the model
% -estimated pCO2 value for a given temperature, we see there is less 
% difference in the Chi-squared value for the quadratic in comparison to the
% linear model.

Residuals2 = norm(R*c - Q'*b)

%Residuals2 = 1.3888e+03

% We see that in comparison to the Chi-Squared values, the residuals are
% larger in values, however both pieces of data show that Quadriatic has a
% lower difference in comparison. 

%% Functions
%
% Gram-Schmidt Orthogonolization
%

function [Q,R] = GramSchmidt(A,p)
[m,n] = size(A);
Q = zeros(m,m);
R = zeros(m,n);

for j = 1:m
    v = A(:,j); 
    for i = 1: j-1
        R(i,j)=Q(:,i)'*v;
        v = v-R(i,j)*Q(:,i);
    end
    R(j,j) = norm(v);
    Q(:,j) = v/R(j,j);
end
R = R(:,1:p);
end
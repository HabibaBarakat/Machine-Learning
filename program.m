clc
clear all
close all

ds = datastore('house_data_complete.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
y=T{:,3};
m=length(y);
sixty=ceil(m*0.6); % 60% of the data
twenty=ceil(m*0.2); % 20% of the data
alpha = 0.01;       % Learning Rate

% Compute the mean square error
%Us are Features, Xs are the hypotheseis
U0=T{1:sixty, 4};
U1=T{1:sixty, 9:11};
U2=U1.^2;
U3=U2.^3;
X1 = [ones(sixty, 1) U0 U1 U2 U3];
X2=[ones(sixty, 1) U1 U2];
X3=[ones(sixty, 1) U1 U1.^2 U1.^3 U1.^4];
X4=[ones(sixty, 1) U0 U0.^3 U1 U1.^2 U1.^3 U1.^4];

%normalization of x (scaling)
N0=Normalization(X1);
%normalization of y (scaling)
Y=T{1:sixty,3}/mean(T{1:sixty,3});

[m,n] = size(X1);      % number of training examples
theta = zeros(n, 1);    % initial weights

%***********Training Data Section 60%***********
% Run Gradient Descent
[Theta, Js] = GradientDescent(N0, Y, theta, alpha,m);

% plotting the error
figure (4);
plot( Js, '-b');
xlabel('number of iterations');
ylabel('error');

%************Cross Validation Section 20%***********
%Us are Features, Xs are the hypotheseis
Thetaa=Theta;
UU0=T{sixty+1:sixty+twenty,4};
UU1=T{sixty+1:sixty+twenty,9:11};
UU2=UU1.^2;
UU3=UU1.^3;
XX1=[ones(twenty,1) UU0 UU1 UU2 UU3];

%normalization of x (scaling)
N1=Normalization(XX1);
%normalization of y (scaling)
YY=T{sixty+1:sixty+twenty,3}/mean(T{sixty+1:sixty+twenty,3});

[a,b] = size(XX1);     % number of training examples

J1 = ComputeCost(N1, YY, Thetaa,a);



%***********Testing Section 20%***********
Thetaaa=Thetaa;
UUU0=T{sixty+twenty+1:end,4};
UUU1=T{sixty+twenty+1:end,9:11};
UUU2=UUU1.^2;
UUU3=UUU1.^3;
XXX1=[ones(twenty-1,1) UUU0 UUU1 UUU2 UUU3];


%normalization of x (scaling)
N2=Normalization(XXX1);
%normalization of y (scaling)
YYY=T{sixty+twenty+1:end,3}/mean(T{sixty+twenty+1:end,3});

[s,l] = size(XXX1); 

J2 = ComputeCost(N2, YYY, Thetaaa,s);


%*****************************************************************************************************************


% Predicting Profits
%fprintf('Prediction for house 1:\t%f\n', ([1:1:n] * theta));


% %Normal Equation
% ThetaNormal=normal(X2,y);
% fprintf('Prediction for house 1 with Normal Equation:\t%f\n', ([1:1:n] * ThetaNormal));


%figure (3);
%title('Gradient Descent');
%hold on;
%plot(X(:, 3), X * theta, '-');
%legend('Training data', 'Linear regression');
%hold off;

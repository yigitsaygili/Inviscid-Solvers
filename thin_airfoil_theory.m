% THIN AIRFOIL THEORY APPLICATION WITH 4TH DEGREE CURVE FITTING
clear; clc;     % Clear previous variables

%% AIRFOIL DEFINITION
% NACA 63206 Airfoil coordinates of upper and lower surfaces
xu=[0, 0.00458, 0.00703, 0.01197, 0.02438, 0.04932, 0.07429, 0.0993, 0.14934, 0.19941, 0.2495, 0.2996, 0.3497, 0.39981, 0.44991, 0.5, 0.55008, 0.60015, 0.6502, 0.70023, 0.75023, 0.80022, 0.85049, 0.90013, 0.95006, 1];
yu=[0, 0.00551, 0.00677, 0.00876, 0.01241, 0.01776, 0.02189, 0.02526, 0.03058, 0.03451, 0.03736, 0.03926, 0.0403, 0.04042, 0.03972, 0.03826, 0.03612, 0.03338, 0.03012, 0.02642, 0.02237, 0.01804, 0.01356, 0.009, 0.00454, 0];
xl=[0, 0.00542, 0.00797, 0.01303, 0.02562, 0.05068, 0.07571, 0.1007, 0.15066, 0.20059, 0.2505, 0.3004, 0.3503, 0.40019, 0.45009, 0.5, 0.54992, 0.59985, 0.6498, 0.69977, 0.74927, 0.79978, 0.84981, 0.89987, 0.94994, 1];
yl=[0, -0.00451, -0.00537, -0.00662, -0.00869, -0.01144, -0.01341, -0.01492, -0.01712, -0.01859, -0.01946, -0.01982, -0.0197, -0.019, -0.01782, -0.0162, -0.01422, -0.01196, -0.00952, -0.00698, -0.00447, -0.00212, -0.0001, 0.00134, 0.00178, 0];

camberline_calc=(yu+yl)/2;                                                                  % Calculating the camberline
camber_fitting=(-0.07092*xu.^4)+(0.1413*xu.^3)+(-0.1306*xu.^2)+(0.06008*xu)+(0.0003009);    % Curve fitting

% Plotting the Airfoil geometry
figure(1)
plot(xu,camberline_calc)
grid on
hold on
plot(xu,yu)
plot(xl,yl)
plot(xu,camber_fitting)
legend("Camberline", "Upper Surface", "Lower Surface", "Curve Fitting")
title("NACA 63206 Airfoil and Camberline")
axis equal

%% CALCULATIONS
syms x theta    % Defining the variables x and theta

camber_line(x) = (-0.07092*x^4)+(0.1413*x^3)+(-0.1306*x^2)+(0.06008*x)+(0.0003009); % Curve Fitting
der_camber_line(x) = diff(camber_line);                                             % Taking derivative
camber_theta = der_camber_line((1-cos(theta))/2);                                   % Variable Transform

alpha = 0;                                                            % Angle of attack
A0 = alpha-double(1/pi()*int(camber_theta, theta, 0, pi()));          % Fourier Coefficient 0
A1 = double(2/pi()*int(camber_theta*cos(theta), theta, 0, pi()));     % Fourier Coefficient 1
A2 = double(2/pi()*int(camber_theta*cos(2*theta), theta, 0, pi()));   % Fourier Coefficient 2

gamma_theta(theta) = (A0*(1+cos(theta))/(sin(theta))) + A1*sin(theta) + A2*sin(2*theta); % Vortex Strength

alpha_cl_0 = double(-1/pi()*int(camber_theta*(cos(theta)-1),theta,0,pi()));  % Zero lift AoA
cm_ac = pi()/4*(A2-A1);                                                      % Moment Coefficient
cl = 2*pi()*(deg2rad(alpha)-alpha_cl_0);                                     % Lift Coefficient

figure(2)
fplot(gamma_theta,[0 pi()])     % Plotting the Sheet Vortex Strength
grid on
xlabel("x/c");
ylabel("gamma(theta)");
title('Sheet Vortex Strength vs Camberline as Theta')
disp(["AoA:       "+alpha; "AoA_Cl=0: "+alpha_cl_0; "Cm_AC:    "+cm_ac; "Cl:        "+cl])
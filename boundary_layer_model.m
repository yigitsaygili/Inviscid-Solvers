% UZB 386E - Finite Difference Boundary Layer Solver - Yigit Saygili
clear; clc;             % Clear previous variables

%% Defining parameters and conditions
Lx = 1;                 % Domain length in x-direction
Ly = 0.025;             % Domain length in y-direction
Nx = 4000;              % Number of elements in x-direction
Ny = 100;               % Number of elements in y-direction
dx = Lx / Nx;           % Element length in x-direction
dy = Ly / Ny;           % Element length in y-direction
nu = 2.1*10^-5;         % Viscosity of the fluid
U_e = 9;                % Frestream Velocity

u = ones(Nx, Ny)*U_e;   % x-component of velocity
v = zeros(Nx, Ny);      % y-component of velocity

u(:,1) = 0;             % Boundary condition: u @ y = 0
v(:,1) = 0;             % Boundary condition: v @ y = 0
u(1,:) = U_e;           % Boundary condition: u @ y = 0

%% Finite difference approximation calculations
for i = 2:Nx-1          % Loop in x-direction
    for j = 2:Ny-1      % Loop in y-direction

        % Finite difference approximations for u
        u(i+1,j) = u(i,j) + nu * ((u(i,j+1) - 2*u(i,j) + u(i,j-1)) / u(i,j)) * (dx/(dy^2)) ...
        - ((u(i,j+1)-u(i,j-1))/2) * (v(i,j)/u(i,j)) * (dx/dy);

        % Finite difference approximations for v
        v(i+1,j) = v(i+1,j-1) - (dy/(2*dx)) * ((u(i+1,j)-u(i,j)) + (u(i+1,j-1)-u(i,j-1)));

    end
end

%% Checking the stability criteria
if dx <= ((u(1,1)*dy^2)/(2*nu))
    disp("Stability criteria is staisfied")
else
    disp("Stability criteria is not staisfied")
end

%% Plotting the velocity distribution in the domain
[X, Y] = meshgrid(linspace(0, Lx, Nx), linspace(0, Ly, Ny));
figure(1)
contourf(X, Y, u');
colorbar
grid on
xlabel('x');
ylabel('y');
title('Contour Plot of "u" Along Flat Plate');

%% Calculating boundary layer parameters
Re = U_e*1*1.225/nu;                    % Reynolds number
x_plate = 0:0.01:1;                     % Flat plate surface
delta= 5*x_plate/sqrt(Re);              % Boundary layer thickness
delta_star = 1.728*x_plate/sqrt(Re);    % Displacement thickness
theta = 0.664*x_plate/sqrt(Re);         % Mometum thickness
shape_factor = delta_star/theta;        % Shape factor
Cf = 0.664/sqrt(Re);                    % Skin friction coefficient
Cd = 1.328/sqrt(Re);                    % Drag coefficient
Drag = 0.5*1.225*U_e^2*1*Cd;            % Drag per unit span

figure(2)                               % Plotting the parameters
plot(x_plate,delta, "LineWidth",1)
grid on
hold on
plot(x_plate,delta_star, "LineWidth",1)
plot(x_plate,theta, "LineWidth",1)
title("Boundary Layer Parameters")
legend("Boundary layer thickness \delta","Displacement thickness \delta^*", ...
    "Mometum thickness \theta", "Location","northwest")

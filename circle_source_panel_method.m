% SOURCE PANEL METHOD - APPLICATION ON CIRCLE SURFACE
clc; clear;       % Clear all previious variables

%% VARIABLES
% Flow properties --------------------------------------------------------
V_inf=10;         % Freestream velocity
alpha=0;          % Angle of attack;

% Geometric properties ---------------------------------------------------
n=100;            % Number of panels
r=1;              % Cylinder radius

d_theta=2*pi/n;                         % Theta transformation
theta=(pi+pi/n):-d_theta:(-pi+pi/n);    % Central angle range

X=r*cos(theta);       % X Coordinate transformation               
Y=r*sin(theta);       % Y Coordinate transformation   

%% CALC
% Definig the cycliner surface panels and control points -----------------
for i=1:n
    % Angle of flow with tangent to panel --------------------------------
    fi(i)=-alpha + atan2((Y(i+1)-Y(i)) , (X(i+1)-X(i)));

    % Definiton of control point locations -------------------------------
    beta(i)=fi(i)+pi/2;
    controlpoint_x(i)=(X(i+1)+X(i))/2;
    controlpoint_y(i)=(Y(i+1)+Y(i))/2;

    % Length of the panel ------------------------------------------------
    S(i)=sqrt((Y(i+1)-Y(i))^2+(X(i+1)-X(i))^2);
end

% The Source Panel Method ------------------------------------------------
for j=1:n
    % Defining the current calculation point -----------------------------    
    neighbors(:,j)=[1:j-1 j+1:n];
    xi=controlpoint_x(j);
    yi=controlpoint_y(j);

    % Defining the relations of current and other points -----------------
    for k=1:n-1
        m=neighbors(k,j);
        Xj = X(m);
        Yj = Y(m);
        Xj1 = X(m+1);
        Yj1 = Y(m+1);

        % Calculation of required coefficients from A1 to A5 -------------
        A_1 = -(xi-Xj)*cos(fi(m)) - (yi-Yj)*sin(fi(m));
        A_2 = (xi-Xj)^2 + (yi-Yj)^2;
        A_3 = sin(fi(j) - fi(m));
        A_4 = (yi-Yj)*cos(fi(j)) - (xi-Xj)*sin(fi(j));
        A_5 = sqrt(A_2-A_1^2);

        % Calculation of required values for velocity and lift -----------
        Sj = S(m);
        I(j,m) = A_3/2 * log((Sj^2+2*A_1*Sj+A_2)/A_2) + (A_4-A_1*A_3)/A_5 * (atan2((Sj+A_1),A_5) - atan2(A_1,A_5));
        J(j,m) = (A_4-A_1*A_3)/2/A_5 * log((Sj^2+2*A_1*Sj+A_2)/A_2) - A_3 * (atan2((Sj+A_1),A_5) - atan2(A_1,A_5));
    end

    F(j,1)=V_inf*cos(beta(j));
end

% Calculation of the total lift force ------------------------------------
M=I/2/pi+eye(n)/2;
lambda=-inv(M)*F;
L=lambda'*S';

% Calculating velocity at the control points -----------------------------
V=V_inf*sin(beta)+lambda'/2/pi*J';

% Calculating pressure coefficient at the control points -----------------
angles = min(beta):0.01:max(beta);
cp_real = 1-4*sin(angles).^2;
cp_calculated  =1-(V/V_inf).^2;

% Plotting the results ---------------------------------------------------
tiledlayout(2,2)
nexttile
plot(X,Y)
axis equal;
grid;
title('Surface Panels of the Cyclinder')

nexttile
plot(controlpoint_x,controlpoint_y,'r.');
axis equal;
grid;
title('Control Points of the Panels')

nexttile
plot(angles,cp_real);
axis equal;
grid;
title('Real Cp Over the Surface')

nexttile
plot(beta,cp_calculated,'r.');
axis equal;
grid;
title('Calculated Cp Over the Surface')
sgtitle(sprintf('Total Lift Force: %f',L))

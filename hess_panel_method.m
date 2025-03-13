% HESS PANEL METHOD - COMPARISON WITH EXPERIMENTAL DATA
clear; clc; close all;       % Clear all previious variables

%% PARAMETERS
v = 1.4207e-5;               % Kinematic Viscosity
Re = 3e6;                    % Reynolds Number
chord = 1;                   % Chord Lenght
V_inf = Re * v / chord;      % Velocity
AoA = -10:1:15;              % Angle of Attack

for i = 1:length(AoA)
    [Cl.a(i,1),Cd.a(i,1)] = panel_method(V_inf,AoA(i),chord);
end

%% DRAWING PLOTS
cl_exp = [
    -5.81716	-0.4583
    -4.47232	-0.3354
    -4.07867	-0.2406
    -3.30784	-0.1555
    -1.76917	-0.0042
    -0.99833	0.08093
    0.345003	0.19437
    1.309665	0.30792
    2.084987	0.42152
    3.046656	0.5161
    4.200659	0.62959
    5.168315	0.76211
    6.508664	0.85657
    7.465843	0.92269
    9.178886	0.9791
    10.50277	0.96922
    11.44498	0.94048
    12.3812	    0.8738  
];

tiledlayout(1,2)
nexttile
plot(cl_exp(:,1),cl_exp(:,2),LineWidth=2)
hold on
plot(AoA, Cl(1).a,LineWidth=2)
legend('Experimental Data','Calculated Data',Location='southeast')
xlabel('Angle of Attack')
ylabel('Lift Coefficient')
title('Cl vs AoA')
grid on

nexttile
plot(Cd(1).a, Cl(1).a, LineWidth=2)
ylabel('Lift Coefficient')
xlabel('Drag Coefficient')
title('Drag Polar Model')
grid on

%% PANEL METHOD FUNCTION
function [Cl,Cd,Strength] = panel_method(V_inf,AoA,chord)
AoA = deg2rad(AoA);

naca_coord =     [
    1.0	        0.0
    0.95006	    0.00454
    0.90013	    0.009
    0.85049	    0.01356
    0.80022	    0.01804
    0.75023	    0.02237
    0.70023	    0.02642
    0.6502	    0.03012
    0.60015	    0.03338
    0.55008	    0.03612
    0.5	        0.03826
    0.44991	    0.03972
    0.39981	    0.04042
    0.3497	    0.0403
    0.2996	    0.03926
    0.2495	    0.03736
    0.19941	    0.03451
    0.14934	    0.03058
    0.0993	    0.02526
    0.07429	    0.02189
    0.04932	    0.01776
    0.02438	    0.01241
    0.01197	    0.00876
    0.00703	    0.00677
    0.00458	    0.00551
    0.0	        0.0
    0.00542	    -0.00451
    0.00797	    -0.00537
    0.01303	    -0.00662
    0.02562	    -0.00869
    0.05068	    -0.01144
    0.07571	    -0.01341
    0.1007	    -0.01492
    0.15066	    -0.01712
    0.20059	    -0.01859
    0.2505	    -0.01946
    0.3004	    -0.01982
    0.3503	    -0.0197
    0.40019	    -0.019
    0.45009	    -0.01782
    0.5	        -0.0162
    0.54992	    -0.01422
    0.59985	    -0.01196
    0.6498	    -0.00952
    0.69977	    -0.00698
    0.74927	    -0.00447
    0.79978	    -0.00212
    0.84981	    -0.0001
    0.89987	    0.00134
    0.94994	    0.00178
    1.0	        0.0
    ];
num = length(naca_coord)-1;

for i = 1:num
    control_point(i,1) = 0.5 * ( naca_coord(i,1) + naca_coord(i+1,1) );
    d(i,1) = (naca_coord(i+1,1)) - (naca_coord(i,1));

    control_point(i,2) = 0.5 * ( naca_coord(i,2) + naca_coord(i+1,2) );
    d(i,2) = (naca_coord(i+1,2)) - (naca_coord(i,2));

    theta(i,1) = atan2(d(i,2),d(i,1));
    ds(i,1) = sqrt(d(i,1)^2 + d(i,2)^2);
end

for i = 1:num
    for j = 1:num
        r(i,j+1) = sqrt((control_point(i,1) - naca_coord(j+1,1))^2 + (control_point(i,2) - naca_coord(j+1,2))^2 );
        r(i,j) = sqrt((control_point(i,1) - naca_coord(j,1))^2 + (control_point(i,2) - naca_coord(j,2))^2 );
        
        if i == j
            beta(i,j) = pi;
        elseif j == num-i+1
            beta(i,j) = (atan((control_point(i,2) - naca_coord(j+1,2))/(control_point(i,1) - naca_coord(j+1,1)))...
                - atan((control_point(i,2) - naca_coord(j,2))/(control_point(i,1) - naca_coord(j,1)))) -pi;
        else
            beta(i,j) = (atan((control_point(i,2) - naca_coord(j+1,2))/(control_point(i,1) - naca_coord(j+1,1)))...
                - atan((control_point(i,2) - naca_coord(j,2))/(control_point(i,1) - naca_coord(j,1)))) ;
        end
    end
end

for i = 1:num
    for j = 1:num
        if i == j
            A_n(i,j) = 0.5;
            A_t(i,j) = 0;
        else
            A_n(i,j) = 1/(2*pi) * ( sin(theta(i) - theta(j)) * log(r(i,j+1)/r(i,j)) + cos(theta(i)-theta(j)) * beta(i,j));
            A_t(i,j) = 1/(2*pi) * ((sin(theta(i)-theta(j)) * beta(i,j)) - (cos(theta(i) - theta(j)) * log( r(i,j+1) / r(i,j))));
        end
    end
end

B_n = -A_t;
B_t = A_n;
A = zeros(num+1,num+1);
A(1:num, 1:num) = A_n;
A(1:num, num+1) = sum(B_n,2);
A(num+1,1:num) = A_t(1,:) + A_t(num,:);          
A(num+1, num+1) = sum((B_t(1,:)+B_t(num,:)) ,2);

for i = 1:num
    b(i,1) = - V_inf * sin(AoA - theta(i)); %Eq. 3.2.24a
end

b(num+1,1) = -V_inf * cos(AoA - theta(1)) - V_inf * cos(AoA - theta(num));
Strength = linsolve(A,b);
At2 = [A_t, sum(B_t,2)];

for i = 1:num
    sum1 = 0;
    for j = 1:num+1
        sum1 = At2(i,j) * Strength(j) + sum1;
    end

    Vt(i,1) = sum1 + V_inf * cos(AoA - theta(i));
    cp(i,1) = 1-(Vt(i)/V_inf)^2;
end

for i = 1:num
    F(i,:) = (1/chord) * (1 - cp(i)) * [-sin(theta(i)); cos(theta(i))] * ds(i);
    cl(i,1) = F(i,2) * cos(AoA) - F(i,1) * sin(AoA);
    cd(i) = F(i,1) * cos(AoA) + F(i,2) * sin(AoA);
end

Cl = sum(cl);
Cd = sum(cd);
end

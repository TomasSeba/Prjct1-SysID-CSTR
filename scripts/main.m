%% This is the main script where the diferent functions are ran
clear; clc


% Adding routes
addpath('../src');

% Loading parameters
p = parameters_cstr;

% Initial conditions
x0 = [0.0376621; 2.1216; 0.143553; 0.226519; 138.642]; % In order: A, B, C, M, T

% Inputs
u = [1000, 950, 5]; % Initial value, final value, time value for the step

% Simulation time
tspan = 0:0.01:10; % Time range, in hours
t_step = 5; % Time where the step will happen

% Simulation
options = odeset('RelTol',1e-12);
[t,x] = ode45(@(t,x) cstr_ode(t,x,u,p),tspan,x0,options);

m_CW = zeros(length(t),1);
for i = 1:length(t)
    u_i = inputs(t(i), u(1), u(2), u(3));
    m_CW(i) = u_i;
end

%% Graphing
C_A = x(:,1); 
C_B = x(:,2); 
C_C = x(:,3); 
C_M = x(:,4);
T = x(:,5);

% Plotting the temperature profile over time
T_p = figure(Name='Temperature profile');
plot(t, T);
xlabel('Time (hours)');
ylabel('Temperature (°F)');
title('Temperature Profile in CSTR');
grid on;

% Plotting the concentration of each component
C_p = figure(Name='Concentration profile');
plot(t,C_A,t,C_B,t,C_C,t,C_M);
xlabel('Time (hours)');
ylabel('Concentration (lbmole/ft3)');
title('Concentrations in CSTR');
legend('A','B','C','M');
grid on;

%Plotting just the concentration of C
% Plotting the concentration of C
C_p_C = figure(Name='Concentration profile of C');
plot(t, C_C);
xlabel('Time (hours)');
ylabel('Concentration of C (lbmole/ft3)');
title('Concentration of C in CSTR');
grid on;

%% System identification

[G_1p, G_2p1z, G_arx] = system_ident(T,m_CW,0.01);
% In this case, the output variable is the temperature, the inlet the cooling water flow rate, 
% the sampling time defined is of 0.01h and the plant is considered to be
% of second-order. Given that it has overshoot and settling time, it also
% has a zero.

%% Comparing systems
t_sim = linspace(0,10,1001);
m_CW_sim = zeros(length(t_sim),1);
for i = 1:length(t_sim)
    u_i = inputs(t_sim(i), u(1), u(2), u(3));
    m_CW_sim(i) = u_i;
end

dT = lsim(G_2p1z,m_CW_sim - mean(m_CW_sim(t_sim < 5)),t_sim);
T_sim = T(1) + dT - dT(2);
T_sim(1) = T_sim(1) + dT(2);

Comp = figure(Name='Comparation between systems');
plot(t_sim,T_sim,t, T)
xlabel('Time (hours)');
ylabel('Temperature (°F)');
title('Temperature Profile in CSTR');
legend('From Second-Order TF', 'From the non-linear model')
grid on;

% Comparing again
T_clean = T - mean(T(t < 5));
m_CW_clean = m_CW - m_CW(1);

DAT_950 = iddata(T_clean(:),m_CW_clean(:),0.01);
Comp_950 = figure(Name='Step down 50');
compare(DAT_950,G_1p,G_2p1z,G_arx)
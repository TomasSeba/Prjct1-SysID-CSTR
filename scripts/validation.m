%% Validation
% In order to validate that the model works, another step will be made.

% Running main
main;

% Simulating a broader step
u = [1000, 900, 5];
tspan = 0:0.01:10; % Time range, in hours
t_step = 5; % Time where the step will happen

% Nonlinear system
options = odeset('RelTol',1e-12);
[t,x] = ode45(@(t,x) cstr_ode(t,x,u,p),tspan,x0,options);
T = x(:,5);

% Transfer function model
t_sim = linspace(0,10,1001);
m_CW_sim = zeros(length(t_sim),1);
for i = 1:length(t_sim)
    u_i = inputs(t_sim(i), u(1), u(2), u(3));
    m_CW_sim(i) = u_i;
end

dT = lsim(G_2p1z,m_CW_sim - mean(m_CW_sim(t_sim < 5)),t_sim);
T_sim = T(1) + dT - dT(2);
T_sim(1) = T_sim(1) + dT(2);

% Plotting
Val = figure(Name='Validation');
plot(t_sim,T_sim,t, T)
xlabel('Time (hours)');
ylabel('Temperature (°F)');
title('Temperature Profile in CSTR');
legend('From Second-Order TF', 'From the non-linear model')
grid on;

% Identifying the system with different steps
u_900 = [1000, 900, 5];
u_1050 = [1000, 1050, 5];

[t_900, x_900] = ode45(@(t,x) cstr_ode(t,x,u_900,p),tspan,x0,options);
[t_1050, x_1050] = ode45(@(t,x) cstr_ode(t,x,u_1050,p),tspan,x0,options);

for i = 1:length(t)
    u_i = inputs(t(i), u_900(1), u_900(2), u_900(3));
    m_CW_900(i) = u_i;
end

for i = 1:length(t)
    u_i = inputs(t(i), u_1050(1), u_1050(2), u_1050(3));
    m_CW_1050(i) = u_i;
end

T_900 = x_900(:,5);
T_1050 = x_1050(:,5);
t_sample = 0.01;

% Cleaning up data
T_900_clean = T_900 - mean(T_900(t < 5));
m_CW_900_clean = m_CW_900 - m_CW_900(1);
T_1050_clean = T_1050 - mean(T_900(t < 5));
m_CW_1050_clean = m_CW_1050 - m_CW_1050(1);

% Using the System Identification Toolbox
DAT_900 = iddata(T_900_clean(:),m_CW_900_clean(:),t_sample);
DAT_1050 = iddata(T_1050_clean(:),m_CW_1050_clean(:),t_sample);

% Comparing
Comp_900 = figure(Name='Step down 100');
compare(DAT_900,G_1p,G_2p1z,G_arx)
Comp_1050 = figure(Name='Step up 50');
compare(DAT_1050,G_1p,G_2p1z,G_arx)

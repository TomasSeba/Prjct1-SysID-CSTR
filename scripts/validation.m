%% Validation
% In order to validate that the model works, another step will be made.

% Running main
main;
close all

% Simulating a broader step
u = [1000, 1050, 5];
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

dT = lsim(G,m_CW_sim - mean(m_CW_sim(t_sim < 5)),t_sim);
T_sim = T(1) + dT - dT(2);
T_sim(1) = T_sim(1) + dT(2);

figure
plot(t_sim,T_sim,t, T)
xlabel('Time (hours)');
ylabel('Temperature (°F)');
title('Temperature Profile in CSTR');
legend('From Second-Order TF', 'From the non-linear model')
grid on;
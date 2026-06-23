%% This is the script which contains the system of ODEs that describe the CSTR

function dxdt = cstr_ode(t,x,u,p)

% Concentration and temperature state in the reactor

C_A = x(1); % Concentration of A in the reactor in lbmole/ft3
C_B = x(2); % Concentration of B in the reactor in lbmole/ft3
C_C = x(3); % Concentration of C in the reactor in lbmole/ft3
C_M = x(4); % Concentration of M in the reactor in lbmole/ft3
T = x(5); % Temperature in the reactor in °F

% Inputs

m_CW = inputs(t,u(1),u(2),u(3)); % Flow of cooling water in lbmole/h

% Rate law

k = p.k0 * exp(p.Ea/(p.R*(T + 460))); % speed factor
r_A = - k * C_A; % Rate law

% Stoichiometry

r_B = r_A; % Both are reactants
r_C = - r_A; % C is a product

% Mole balances

dC_A = r_A + (p.C_A0 - C_A) * p.vo / p.V; % Mole balance in A
dC_B = r_B + (p.C_B0 - C_B) * p.vo / p.V; % Mole balance in B
dC_C = r_C - C_C * p.vo / p.V; % Mole balance in C
dC_M = (p.C_M0 - C_M) * p.vo / p.V; % Mole balance in M

% Energy balance

Q = m_CW * p.Cp_CW * (p.Ta1 - T) * (1 - exp(- p.UA / (m_CW * p.Cp_CW))); % Heat transfered from the vessel to the CW
Ta2 = T - (T - p.Ta1) * exp(- p.UA / (m_CW * p.Cp_CW)); % CWR temperature
NiCpi = (p.Cp_A * C_A + p.Cp_B * C_B + p.Cp_C * C_C + p.Cp_M * C_M) * p.V;
dT = (Q - p.F_A0 * p.Theta_i * (T - p.T0) + p.H_rxn * r_A * p.V)/NiCpi; % Temperature differential equation

dxdt = [dC_A; dC_B; dC_C; dC_M; dT];

end
%% This is the script where the parameters for the cstr are kept

function p = parameters_cstr()

% General reactor parameters
    p.V = 500 / 7.484; % Volume in gallons for the reactor
    p.UA = 16000; % Global heat transfer coefficient * Area for the system (Btu/h°F)

% Reaction parameters
    p.k0 = 16.96e12; % Pre-exponential term for the Arrhenius equation
    p.Ea = -32400; % Activation energy for the reaction in Btu/lbmol
    p.R = 1.9872; % Ideal gas constant in Btu/lbmol_°R
    p.H_rxn = -36000; % Heat of reaction in Btu/lbmole_A

% Heat capacities

    p.Cp_A = 35; % Heat capacity of A in Btu/lbmole_°F
    p.Cp_B = 18; % Heat capacity of B in Btu/lbmole_°F
    p.Cp_C = 46; % Heat capacity of C in Btu/lbmole_°F
    p.Cp_M = 19.5; % Heat capacity of M in Btu/lbmole_°F

% Feed parameters

    p.T0 = 75; % Temperature of feed in °F

    p.F_A0 = 80; % Flow of ethylene oxide (A) in lbmole/h
    p.F_B0 = 1000; % Flow of water (B) in lbmole/h
    p.F_M0 = 100; % Flow of methanol (M) in lbmole/h

    p.rho_A = 0.923; % Density of A in lbmol/ft3
    p.rho_B = 3.45; % Density of A in lbmol/ft3
    p.rho_M = 1.54; % Density of A in lbmol/ft3

    p.vo = p.F_A0/p.rho_A + p.F_B0/p.rho_B + p.F_M0/p.rho_M; % Volumetric flow at the entrance of the reactor in ft3/h
    p.Theta_i = (p.Cp_A * p.F_A0 + p.Cp_B * p.F_B0 + p.Cp_M * p.F_M0) / p.F_A0; % Feed heat capacity term

    p.C_A0 = p.F_A0/p.vo; % Concentration of A in the feed stream in lbmole/ft3
    p.C_B0 = p.F_B0/p.vo; % Concentration of B in the feed stream in lbmole/ft3
    p.C_M0 = p.F_M0/p.vo; % Concentration of M in the feed stream in lbmole/ft3

% Cooling parameters

    p.Ta1 = 60; % Temperature of cooling water in °F
    p.Cp_CW = p.Cp_B; % Heat capacity of water

end

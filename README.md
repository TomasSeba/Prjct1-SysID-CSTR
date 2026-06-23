# System Identification of a Nonlinear CSTR

This project simulates a nonlinear Continuous Stirred Tank Reactor (CSTR) and identifies a transfer function model from step-response data.

## Objective

The objective is to obtain a linear dynamic model relating cooling water flow rate to reactor temperature around a nominal operating point.

## System

The nonlinear CSTR model includes:
- Component mole balances
- Energy balance
- Arrhenius reaction kinetics
- Cooling water heat transfer model

It is based in the example 9-4 "Startup of a CSTR", from Fogler's book "Elements of Chemical Reaction Engineering".

## Workflow

1. Define process parameters.
2. Simulate the nonlinear CSTR model.
3. Apply a step change in cooling water flow.
4. Generate input-output data.
5. Estimate a transfer function using MATLAB System Identification Toolbox.
6. Compare nonlinear and identified model responses.

## Main files

- `main.m`: main simulation script.
- `cstr_ode.m`: nonlinear CSTR model.
- `parameters_cstr.m`: process parameters.
- `inputs.m`: input step function.
- `system_ident.m`: transfer function estimation.

## Tools

MATLAB, Control System Toolbox, System Identification Toolbox.
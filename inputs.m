%% This scripts contains the inputs to the system
function u = inputs(t,u0,u1,t_stp)
    if t < t_stp
        u = u0;  % Define input value for t < 10
    else
        u = u1;  % Define input value for t >= 10
    end
end
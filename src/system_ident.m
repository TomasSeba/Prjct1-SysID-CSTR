%% This script contains the system identification code

function [G1,G2,G3] = system_ident(y,u,tsample)

% Cleaning up data
    y_clean = y - min(y);
    u_clean = u - u(1);

% Using the System Identification Toolbox
    DAT = iddata(y_clean(:),u_clean(:),tsample);
    G1 = tfest(DAT,1,0);
    G2 = tfest(DAT,2,1);
    G3 = arx(DAT,[2 2 1]);

end
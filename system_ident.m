%% This script contains the system identification code

function SysID = system_ident(y,u,tsample,np,nz)

% Cleaning up data
    y_clean = y - min(y);
    u_clean = u - u(1);

% Using the System Identification Toolbox
    DAT = iddata(y_clean,u_clean,tsample);
    SysID = tfest(DAT,np,nz);

end
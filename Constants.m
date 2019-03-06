%% Script for loading necessary constant values

%rng('shuffle')          % shuffle seed for random generation
Msun = 1.98847 * 10^30; % [kg]
Mjup = 1.89813 * 10^27; % [kg]
Rjup = 0.000477895;     % [AU]
Vjup = (4 / 3) * pi * (Rjup^3);  % [AU^3]
djup = 1 / Vjup;        % [JupMass / AU^3]
Pjup = 0.5;             % Geometric albedo of Jupiter-like planets
dmag0 = 22.5;           % Maximum DeltaMag value
G = 2.8245e-07;         % [AU^3 / (JupMass * days^2)]
YearDays = 365;         % [days]
IWA = 0.1;              % [arcsec]
OWA = 0.5;              % [arcsec]
r2d = 360 / (2 * pi);   % radians to degrees
d2r = (2 * pi) / 360;   % degrees to radians

                 
checktime = 365e3;               % Indicate checktime
dtoutput = checktime / 10;       % Indicate dtoutput

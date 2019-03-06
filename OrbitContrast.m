function [contrast, per] = OrbitContrast(a, e, I, om, RAAN, mp, ms)
% Description: The following function calculates and compares the constrant
% values of a particular exoplanet in a particular orbit

% Input: 
    % - All: Orbital elements of the corresponding exoplanet

% Output: 
    % - contrast: Array containing the contrast values for each orbital
    % point
    % - per: Percentage of imageable points in the orbit 

Constants;                                  % load constant values

rp = ((3 * mp) / (4 * pi * djup))^(1 / 3);  % calculate planet radius

Npoints = 100;                              % set number of points studied in the orbit
Nobs = 0;                                   % set number of imageable points to 0
contrast = zeros(1, Npoints);               % Initialize contrast vector
Mvect = linspace(0, 2 * pi, Npoints);       % create vector of mean anomalies

for i = 1 : Npoints                                 % iterate over orbital points
    
    M = Mvect(i);                                   % asign current mean anomaly
    mu = G * (mp + ms);                             % calculate gravitational parameter
    SV = OE2SV(a, e, I, om, RAAN, M, 0, mu, 0);     % obtain state vector from orbital elements
    
    r = sqrt(SV(1)^2 + SV(2)^2 + SV(3)^2);          % calculate distance from star
    rproj = sqrt(SV(1)^2 + SV(2)^2);                % calculate distance projection
    beta = asin(rproj / r);                         % obtain phase angle
    phase = (sin(beta) + (pi - beta) * cos(beta)) / pi;           % compute phase function value
    contrast(i) = -2.5 * log10(Pjup * phase * ((rp / r) ^ 2));    % obtain contrast value
    
    if contrast(i) <= dmag0                         % check if value is in imageable region
        Nobs = Nobs + 1;                            % update number of imageable points
    end
end
per = Nobs / Npoints;

end


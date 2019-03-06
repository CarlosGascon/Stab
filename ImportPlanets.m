%% Import Exoplanet Data - Script

% Description: The following script imports and saves the data of the known
% exoplanets from an external file ('planets.csv'). The data for each 
% exoplanet is saved as a struct formed by the different fields described 
% through the script. Exoplanets whose semimajor axis, eccentricty,
% longitude of periastron, star distance or mass is unknown, are discarded.

Constants;                    % Import constant values needed
P = readtable('planets.csv'); % Read external file 'planets.csv'
P = table2struct(P);          % Transform table to struct format 
Exoplanets = [];              % Initialize the exoplanets array 

for i = 1 : length(P)
    Exoplanet.system = P(i).pl_hostname;            % Read system name (star name)
    Exoplanet.smass = P(i).st_mass * (Msun / Mjup); % Read star mass in Solar Masses and transform to Jupiter Masses
    Exoplanet.plet = P(i).pl_letter;                % Read planet letter
    Exoplanet.I = P(i).pl_orbincl * d2r;            % Read orbit inclination [deg] and convert to rad
    if  ~isnan(P(i).pl_orbsmax)                     % Check semimajor axis existence
        Exoplanet.a = P(i).pl_orbsmax;              % Read semimajor axis [AU]
        
        if ~isnan(P(i).pl_orbeccen)                 % Check eccentricity existence
            Exoplanet.e = P(i).pl_orbeccen;         % Read eccentricity
            
            if ~isnan(P(i).pl_orblper)              % Check longitude of periastron existence
                Exoplanet.om = P(i).pl_orblper * d2r;           % Read longitude of periastron [deg] and convert to rad
                
                if ~isnan(P(i).st_dist)             % Check star distance existence
                    Exoplanet.dist = P(i).st_dist;  % Read star distance [pc]

                    if ~isnan(P(i).pl_bmassj)                   % Check planet mass existence
                        Exoplanet.pmass = P(i).pl_bmassj;       % Read planet mass in Jupiter Masses
                        Exoplanet.type = P(i).pl_bmassprov;     % Read planet type (Mass or Msini)
                        Exoplanet.per = P(i).pl_orbper;         % Read Orbital Period [days]
                        Exoplanets = [Exoplanets, Exoplanet];   % Add current exoplanet to array
                    end
                end
            end
        end
    end
    
end
save('Exoplanets', 'Exoplanets');
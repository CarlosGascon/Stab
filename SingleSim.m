function [Stable, Imageable, time] = SingleSim(KnownExo, Nexo, YearsSim, a, e, Mexo)
% Description: The following function performs one simulation for a
% specific system. Reading the information from the known exoplanets of the
% particular system, a new random exoplanet is generated. The entire system
% is then integrated over the period of time specified by 'YearsSim'. While
% integrating, after a period of time determined by 'checktime', the
% stability conditions are checked. Depending on the result, the
% integration continues or ends. 

% Input: 
    % - KnownExo: Array formed by the exoplanets contained in the system  
    % analyzed and specified in TargetList. Each array element consists
    % of an exoplanet struct. 
    % - YearsSim: Simulation time in years. 

% Output: 
    % - Stable: Boolean indicating if the simulated case is stable or not.
    
Constants;            % Load constant values    
Imageable = 1;
m = length(KnownExo); % Number of known exoplanets
n = m + Nexo;            % Total number of planets (Known and Random)

if Nexo > 0
    Imageable = 0;
    for i = 1 : Nexo
        RandomExos(i) = GenerateExo(KnownExo);              % Generate random exoplanet
        RandomExos(i).a = a;
        RandomExos(i).e = e;
        RandomExos(i).pmass = Mexo;
        if RandomExos(i).a > 0
            Imageable = 1;
        end
    end
    Exo = [KnownExo, RandomExos];                % Create vector containing known and random exoplanet
else
    Exo = KnownExo;
end

if Imageable == 0
    Stable = 0;
else 
    Imageable = 1;
    [y_in, dy_in, mus] = InitialCond(Exo);      % Calculate system's initial conditions

    InitialDist = zeros(1, n);                  % Initialize planets distance from star
    StarInitPos = y_in(end - 2 : end);          % Star intial position
    for i = 1 : n                                          % Iterate over every planet
        PlanetPos = y_in((3 * i - 2) : 3 * i);             % Planet initial position
        InitialDist(i) = norm(PlanetPos - StarInitPos);    % Calculate and store planet intial distance from star
    end

    dt = min([Exo.per]) / 13;                    % Time step a ninth of the minimum orbital period of the system   
    t_in = [dt; YearsSim * 365; checktime; dtoutput];           % Rebound time parameters            
    SimTime = 0;                                % Initialize SimTime
    Stable = 1;                                 % Initialize Stability flag
    [t_out, y_out, dy_out] = reboundmexmod(t_in, y_in, dy_in, mus); % Run n body integration with rebound
    
    time = t_out(end);
   %time = 0;
     
end

end
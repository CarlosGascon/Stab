function [RandomExo] = GenerateExo(KnownExo)
% Description: The following function Generates a random exoplanet in the
% imageable region defined by the geometric and contrast limtiations. The
% random exoplanet structure contains the same fields as the knowns
% exoplanets. 

% Input:
    % - KnownExo: Array containing the structs for the known exoplanets in
    % the system analyzed. 

% Output: 
    % - RandomExo: Struct containing the information of the random
    % exoplanet generated

Constants;                                  % Load constant values 
RandomExo.system = KnownExo(1).system;      % Asign system nam
RandomExo.smass = KnownExo(1).smass;        % Asign system mass
RandomExo.plet = 'rand';                    % Asign planet letter 'rand' for random

RandomExo.I = acos((2 * rand - 1) * 0);           % Generate inclination

RandomExo.e = raylrnd(0.21);                % Generate eccentricity

RandomExo.om = 2 * pi * rand;               % Generate Longitude of periastron
RandomExo.dist = KnownExo(1).dist;          % Asign star distance
RandomExo.pmass = sampleDist(@(m) m.^(-1.31),1,[0.5 12],34);    %IMPORTANT: LOOK

RandomExo.RAAN = 2 * pi * rand * 0;             % Generate Longitude of ascending node
RandomExo.M0 = 0;                           % Set mean anomaly to 0
RandomExo.T = 0;     

amin = IWA * KnownExo(1).dist;              % Calculate minimum geometric semimajor axis
amax = OWA * KnownExo(1).dist;              % Calculate maximum geometric semimajor axis

[amin, amax, nonimag] = PhotometricConstraints(RandomExo, amin, amax);
if nonimag == 0
    RandomExo.a = sampleDist(@(a) a.^(-0.62).*exp(-2*a./(30)),1,[amin amax],35); % IMPORTANT: LOOK
else 
    RandomExo.a = 0;
end
RandomExo.per = 2 * pi * sqrt((RandomExo.a ^ 3) ...             
                / (G * (RandomExo.smass + RandomExo.pmass))) ;  % Calculate Orbital Period
                       
end


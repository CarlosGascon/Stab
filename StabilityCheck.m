function [Stable] = StabilityCheck(y_out, dy_out, mus, InitialDist, n)
%Description: The following function performs the stability check of the
%system for the given current position of the planets. 

%Input:
    % - y_out: Current position of the system exoplanets
    % - dy_out: Current velocity of the system exoplanets
    % - mus: gravitational parameters of exoplanets and star
    % - InitialDist: Exoplanets initial distance from star 

%Output:
    % - Stable: Boolean indicating if the simulated case is stable or not.

Stable = 1;
FinalDist = zeros(1, n);                                  % Initialize FinalDist vector
StarFinalPos = y_out(end - 2 : end, end);                 % Calculate star final position
FinalKepEng = zeros(1, n);                                % Initialize FinalKepEng vector

for i = 1 : n
    PlanetPos = y_out((3 * i - 2) : 3 * i, end);          % Planet final position
    FinalDist(i) = norm(PlanetPos - StarFinalPos);        % Calculate and store planet final distance from star
    PlanetVel = norm(dy_out((3 * i - 2) : 3 * i, end));   % IMPORTANT: SHOULD BE RELATIVE VEL??
    FinalKepEng(i) = (PlanetVel ^ 2) / 2 - mus(end) / FinalDist(i);     % Calculate Planet Keplerian energy
end

DistProp = FinalDist ./ InitialDist;                      % Calculate distance proportion for every planet
                                       
if(any(DistProp > 5) == 1 || any(FinalKepEng > 0) == 1)   % Check stabilty criteria
   Stable = 0; 
end

end


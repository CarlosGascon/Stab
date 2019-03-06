function [StableOrbs, time] = Run_Sims(TargetList, Nexo, Norb, YearsSim, Ncores)
% Description: The following function runs several simulations (Norb) for
% each Target system. 
% Input: 
    % - All: Input is formed by the TargetList struct, containing the 
    % system and planets of the correspoding system which must be 
    % simulated. Norb defines de number of study cases for each system,
    % while YearsSim indicates de years of simulation for each case. 
% Output: 
    % - Stability: Contains the results for each system studied. In
    % particular the number and percentage of stable orbits is stored.
Constants;
parpool(Ncores)                         % Starting parallel pool
Targets = ImportData(TargetList);       % Import struct with each target properties
cont = 1;

a = linspace(Targets{1}(1).dist * IWA, Targets{1}(1).dist * OWA, 4)
%a = linspace(11.60, 16, 3)
e = linspace(0, 0.5, 4)
Mexo = 0.5;

for i = 1 : length(Targets)             % Iterate over every system target
    StableOrbs = zeros(length(a), length(e));        % Initialize stable orbits vector
    ImageableOrbs = zeros(length(a), length(e));     % Initialize imageable orbits vector
    Time = zeros(length(a), length(e));
    Target = Targets{i};                % Select target system to be studied
    
    parfor (j = 1 : length(a), Ncores)                       % Start Parallel pool
    %for j = 1 : length(a)
        vec1 = zeros(1, length(e));
        vec2 = zeros(1, length(e));
        vec3 = zeros(1, length(e));
        for k = 1 : length(e)
             
             [vec1(k), vec2(k), vec3(k)] = SingleSim(Target, Nexo, YearsSim, a(j), e(k), Mexo);    % Calculate stability for particular case

        end
        1
        StableOrbs(j, :) = vec1;
        ImageableOrbs(j, :) = vec2;
        time(j, :) = vec3;
    end
    %{
    System = Targets{i}(1).system;                      % Get system name
    NStable = sum(StableOrbs);                          % Calculate number of stable orbits
    NImageable = sum(ImageableOrbs);
    Stability(i, :) = {System, NImageable, NStable, ...
                       (NStable / Norb) * 100, (NStable / NImageable) * 100};% Store results in stability cell matrix
    
    fprintf('%i%%\n',floor((cont/(length(Targets)) * 100)))
    cont = cont + 1;
    %}
end
end
function [amin, amax, nonimag] = PhotometricConstraints(Exo, amin, amax)
% Description: The following function updates the semimajor axis range by
% taking into account the photometric constraints.

% Input: 
    % - Exo: 
    % - amin:
    % - amax:
% Output: 
    % - amin:
    % - amax:
    % - nonimag: 

nonimag = 0;                            % Set nonimageable flag to 0    
Norbs = 100;                            % Number of cases to be analyzed
avect = linspace(amin, amax, Norbs);    % Values of semimajor axis from amin to amax
minflag = 0;                            % Set  minimum semimajor axis flag to 0
maxflag = 0;                            % Set  minimum semimajor axis flag to 0

for i = 1 : length(avect)               % iterate over the different values of a
    Exo.a = avect(i);                   % Set exoplanet semimajor axis to current value
    [contrast, per] = OrbitContrast(Exo.a, Exo.e, Exo.I, Exo.om, ...
                                    Exo.RAAN, Exo.pmass, Exo.smass);
    if minflag == 0                     % if minimum value is still not set
        if per > 0                      % if contrast percentage is above 0
            amin = avect(i);            % set current value as minimum semimajor axis
            minflag = 1;                % update minimum flag to 1
        end
    end
    if minflag == 1                     % if minimum is found
        if maxflag == 0                 % if maximum is still not found
            if per == 0                 % if contrast percentage is 0
                amax = avect(i);        % set current value as maximum semimajor axis
                maxflag = 1;            % update maximum flag to 1
            end
        end
    end    
end

if minflag == 0                         % if minimum value is not found
    nonimag = 1;                        % set nonimageable flag to 1
end

end


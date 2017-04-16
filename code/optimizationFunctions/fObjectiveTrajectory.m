function f = fObjectiveTrajectory(x, parameters)
% Group all objective function parameters
% f1 = fTotalFlightError(x, parameters) / 2e3; % 1e3 is utopia
f2 = fTotalJerk(x); % 6e-3 is utopia
% f3 = fFinalDistance(x, parameters);

f = [f2];

end
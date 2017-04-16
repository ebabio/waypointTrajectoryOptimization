function g = gConstraintsTrajectory(x, parameters)
% Group all inequality constraints

g1 = gManeuverabilityConstraints(x, parameters);
g2 = gNoFlyConstraints(x);

% They can be implemented as bounds
g = [g2];

end
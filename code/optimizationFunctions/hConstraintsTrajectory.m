function h = hConstraintsTrajectory(x, parameters)
% Group all inequality constraints

h1 = hInitialFinalConditions(x, parameters);
h2 = hKinematicConstraints(x, parameters);

h = [h1; h2];

end
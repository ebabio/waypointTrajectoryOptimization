function [g,h] =  ghConstraintsTrajectory(x, parameters)
% Group all constraints

g = gConstraintsTrajectory(x, parameters);
h = hConstraintsTrajectory(x, parameters);

end
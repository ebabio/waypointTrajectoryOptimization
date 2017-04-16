function f = fTotalFlightError(x, parameters)
% Compute the mean squared flight error for a given trajectory

%% Handle input vector;
checkTrajectoryVector(x);

[trajectory, m, n] = vectorToTrajectory(x);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

%% Evaluate function

xError = x.^2;
yError = y.^2;

flightError = min(xError, yError);
totalError = sum(flightError)*parameters.dt;

f = totalError/parameters.tf;

end


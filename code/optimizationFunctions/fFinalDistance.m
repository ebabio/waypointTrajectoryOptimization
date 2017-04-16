function f = fFinalDistance(x, parameters)
% Compute the mean squared jerk for a given trajectory

%% Handle input vector;
checkTrajectoryVector(x);

[trajectory, m, n] = vectorToTrajectory(x);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

%% Evaluate function
d = (parameters.v * parameters.tf -parameters.initialDistance);
f = d - y(end);
end


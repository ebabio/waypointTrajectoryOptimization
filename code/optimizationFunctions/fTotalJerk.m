function f = fTotalJerk(x)
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

jerk = rollRate .* 9.81.* (1 + roll.^2);
jerkError = jerk.^2;
totalJerk = sum(jerkError);

f = 1/n .* totalJerk;

end


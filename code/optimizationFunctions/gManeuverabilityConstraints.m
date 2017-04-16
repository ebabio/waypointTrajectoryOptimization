function g = gManeuverabilityConstraints(x, parameters)
% Compute the inequality constraints values for the plane's maneuverability
% limits
% All g is linear
%% Handle input vector;
checkTrajectoryVector(x);

[trajectory, m, n] = vectorToTrajectory(x);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

maxRoll = parameters.maxRoll;
maxRollRate = parameters.maxRollRate;
%% Evaluate function
constraintsPerInstant = 4;

g = zeros(n*constraintsPerInstant,1);

for i=1:n
    index = (i-1)*constraintsPerInstant;
    % Each constraint is split into two to preserve linearity
    g(index+1) = roll(i) - maxRoll;
    g(index+2) = - roll(i) - maxRoll;
    g(index+3) = rollRate(i) - maxRollRate;
    g(index+4) = - rollRate(i) - maxRollRate;
end

end
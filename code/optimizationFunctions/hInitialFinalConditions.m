function h = hInitialFinalConditions(x, parameters)
% Compute the equality constraint value for the problem's initial and final
% conditions
% All h is linear
%% Handle input vector;
checkTrajectoryVector(x);

[trajectory, m, n] = vectorToTrajectory(x);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

%% Evaluate function

global initialPoint
global initialSatisfy
global finalPoint
global finalSatisfy
h = zeros(10,1);

% Initial conditions
h(1:5) = (initialSatisfy').*(trajectory(:,1) - initialPoint');

% Final conditions
h(6:10) = (finalSatisfy').*(trajectory(:,end) - finalPoint');
end


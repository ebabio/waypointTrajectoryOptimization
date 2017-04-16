function h = hKinematicConstraints(x, parameters)
% Compute the equality constraints value for the problem's kinematics
% The n-1 first h elements are linear
%% Handle input vector;
checkTrajectoryVector(x);

[trajectory, m, n] = vectorToTrajectory(x);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

v = parameters.v;
dt = parameters.dt;

%% Evaluate function
constraintsPerInstant = 4;
h = zeros((n-1)*constraintsPerInstant,1);
for i=1:n-1
    index = n-1;
    h(i) = roll(i+1) - (roll(i) + cos(roll(i))*rollRate(i)*dt);
    h(index+i) = heading(i+1) - (heading(i) + (9.81/v)*tan(roll(i))*dt);
    h(2*index+i) = x(i+1) - (x(i) + v*cos(heading(i))*dt);
    h(3*index+i) = y(i+1) - (y(i) + v*sin(heading(i))*dt);
end

end


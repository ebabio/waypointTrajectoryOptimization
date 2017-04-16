function g = gNoFlyConstraints(x)
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

noFlyCenter = [-1.5e3     2e3     2e3;    0    0    -3e3];
noFlyRadius = [1e3      1e3     1e3];
%% Evaluate function
k = size(noFlyCenter,2);
g = zeros(n*k,1);
for i=1:k
    radius = (x-noFlyCenter(1,i)).^2 + (y-noFlyCenter(2,i)).^2;
    index = (i-1)*n+1;
    g(index:index+n-1) = (-radius + noFlyRadius(i).^2)';
end
end
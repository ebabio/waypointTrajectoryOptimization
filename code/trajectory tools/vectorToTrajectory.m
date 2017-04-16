function [trajectory, m, n, dt] = vectorToTrajectory(x)

checkTrajectoryVector(x);

l = numel(x);
m = 5;
n = l/5;

trajectory = zeros(m, n);
for i=1:m
    index = n*(i-1);
    trajectory(i,:) = x(index+1 : index+n);
end
end

function [x, l] = trajectoryToVector(trajectory)

[m, n] = size(trajectory);
l = m*n;
x = zeros(l, 1);

for i=1:m
    index = n*(i-1);
    x(index+1 : index+n) = trajectory(i,:);
end
checkTrajectoryVector(x);

end
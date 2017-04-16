function trajectory = generateInitialTrajectory(trajectory, nOfPoints)

%% Extract information from trajectory
dx = trajectory(1,end)-trajectory(1,1);
dy = trajectory(2,end)-trajectory(2,1);

dist = sqrt(dx^2 + dy^2);
heading = atan2(dy,dx);

distChar = 1e3;
n = floor(dist/distChar); %number of modes in fourier series

%% Generate random fourier series
x = 0:1/(nOfPoints-1):1;
y = zeros(size(x));
maxY = .33;
for i=1:n
    random = randn(1)/i^2;
    y = y + maxY .* random .* sin(i*pi*x);
end


quotient = max(abs(y))/maxY;
if(quotient>1)
    y = y/quotient;
end
%% Rotate to match trajectory axis
rotMat = [cos(heading) -sin(heading); sin(heading) cos(heading)];

position = rotMat * dist * [x; y] + trajectory(1:2,1)*ones(1,nOfPoints);

trajectory = zeros(5,nOfPoints);
trajectory(1:2,:) = position;
trajectory(3,:) = heading;

end
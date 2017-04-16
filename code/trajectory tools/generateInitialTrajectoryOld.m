function [trajectory,n] = generateInitialTrajectory(parameters, trajId)
% Computes an initial trajectory that goes to the origin and turns right
%% Check inputs
if(parameters.initialDistance >= 0)
    error('error 1: initial distance must be less than 0');
end

%% Initialize trajectory
n = floor(parameters.tf/parameters.dt)+1;

x = zeros(1,n);
y = zeros(1,n);
heading = zeros(1,n);
roll = zeros(1,n);
rollRate = zeros(1,n);

%% Compute trajectory

%%Turn from N to E
x = (0:n-1) * parameters.v * parameters.dt + parameters.initialDistance;

for i=1:n
    if(x(i) >= 0)
        y(i) = x(i);
        x(i) = 0;
        heading(i) = pi/2;        
    end
end

trajectoryNE = [x; y; heading; roll; rollRate];

%% Direct trajectory
dx = parameters.initialDistance/n;
x = parameters.initialDistance - (0:n-1) * dx;

dy = sqrt(parameters.dt.^2 * parameters.v.^2 - dx^2);
y = (0:n-1) * dy;

trajectoryDi = [x; y; heading; roll; rollRate];

%% Trajectory decision

if(trajId == 1)
    trajectory = trajectoryNE;
elseif(trajId == 2)
    trajectory = trajectoryDi;
else
    weight = rand(1);   
    trajectory = weight * trajectoryNE + (1 - weight) * trajectoryDi;
end

end
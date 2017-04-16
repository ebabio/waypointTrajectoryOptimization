%% Trajectory Optimization

% Optimize a trajectory in terms of flight error and jerk

%% Setup workspace

close all
clear
clear global
addpath(genpath(pwd))
clc

%% Runtime options

nOfPoints = 25;

display = 1;
log = 1;
sequentialRuns = 0; % 0 for 1 run
multiStart = 1000;

%% Initialize Problem Parameters

nOfPoints = (nOfPoints) / (2.^sequentialRuns);

d =4e3;
maxRoll     = pi/4;  % 45 degrees
maxRollRate = pi/8;  % 22.5 deg/s

f0 = 'tf';              v0 = 125;
f1 = 'dt';              v1 = v0/nOfPoints;
f2 = 'v';               v2 = 100;
f3 = 'maxRoll';         v3 = maxRoll;
f4 = 'maxRollRate';     v4 = maxRollRate;

global parameters
parameters = struct(f0,v0, f1,v1, f2,v2, f3,v3, f4,v4);

% Set boundary conditions
global initialPoint
initialPoint    = [-5e3,    1e3,    0,      0, 0];
global initialSatisfy
initialSatisfy  = [1,       1,      1,      1, 1];
global finalPoint
finalPoint      = [5e3,     -2e3,   0,      0, 0];
global finalSatisfy
finalSatisfy    = [0,       1,      1,      1, 1];

global trajName

%% Handle multistart
checkForNewMinima(0, 1);
if(multiStart < 1 || multiStart > 10000)
    multiStart=0;
end
runsLeft = multiStart + 1;
for dummy = 1:runsLeft
    tic
    disp(['minimization attempt number:' num2str(dummy)])
    dt = parameters.dt;
    
    %% Generate Initial Trajectory
    
    trajectory = [initialPoint; finalPoint]';
    
    % Deterministically
%     initialTrajectory = interpolateTrajectory(trajectory, parameters.dt, nOfPoints-2);
    % Randomly
    initialTrajectory = generateInitialTrajectory(trajectory, nOfPoints);
    trajectory = initialTrajectory;
    
    sequentialRunsLeft = sequentialRuns;
    while(sequentialRunsLeft >= 0)
        if(sequentialRunsLeft ~= sequentialRuns)
            
            % Interpolate trajectory
            [trajectory, dt] = interpolateTrajectory(trajectory, dt, 1);
        end
        sequentialRunsLeft = sequentialRunsLeft - 1;
        n = size(trajectory,2);
        
        % Initial State
        x0 = trajectoryToVector(trajectory);
        
        %% Setup problem
        
        % Bounds
        lb = [-2*d*ones(n,1);-2*d*ones(n,1);   -pi*ones(n,1);    -maxRoll*ones(n,1);   -maxRollRate*ones(n,1)];
        ub = [2*d*ones(n,1);  2*d*ones(n,1);    pi*ones(n,1);     maxRoll*ones(n,1);    maxRollRate*ones(n,1)];
        
        % Initial state
        
        x = x0;
        % Options
        maxFunEvals = inf;
        maxIter = 2000;
        options = optimoptions('fmincon','Algorithm','sqp', 'Display','none','MaxFunEvals',maxFunEvals,'MaxIter',maxIter);
        
        % Functions
        f = @(x) fObjectiveTrajectory(x, parameters);
        ghNL = @(x) ghConstraintsTrajectory(x, parameters);
        
        %% Solve problem
        
        [x, fVal, exitflag, output, lambda, fGrad] = ...
            fmincon(f , x0, [], [], [],[], lb, ub, ghNL, options);
        if(exitflag ~= 1)
            warning(['Local minimum may not be achieved: exitflag =' num2str(exitflag)]);
        end
        
        trajectory = vectorToTrajectory(x);
    end
    
    %% Handle results
    new=0;
    if(exitflag>0)
        new = checkForNewMinima(fVal, 0);
        
        if(new)
            disp('New local minimum found');
            fVal = fObjectiveTrajectory(x, parameters);
            [g, h] = ghConstraintsTrajectory(x, parameters);           
            
            date = char(datetime('now','Format','yyyyMMdd''_''HHmmss'));
            
            % display
            if(display)
                trajName = ['Initial_Trajectory_' date];
                plotTrajectory(initialTrajectory, parameters.dt, 0, log);
                cf = gcf();
                plotConstraints(cf.Number);
                
                trajName = ['Final_Trajectory_' date];
                plotTrajectory(trajectory, parameters.dt, 0, log);
                cf = gcf();
                plotConstraints(cf.Number);
                
                plotTrajectory(trajectory, parameters.dt, 2, log);
                pause(1);
            end
            
            % log
            if(log)
                trajName = ['Initial_Trajectory_' date];
                logTrajectory(trajName,initialTrajectory, parameters, exitflag, output.iterations, output.funcCount);
                trajName = ['Final_Trajectory_' date];
                logTrajectory(trajName,trajectory, parameters, exitflag, output.iterations, output.funcCount);
            end
        else
            disp('local minimum previously found');
        end
    end
    toc
    fprintf('\n\n')
end
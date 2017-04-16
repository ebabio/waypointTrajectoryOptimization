%% Load trajectories

%% Setup workspace

close all
clear
addpath(genpath(pwd))
clc

display = 1;
%% Load all trajectories in logs folder

logs = dir('logs');

n = numel(logs);
j = 1;
fAll = [];
for i = 1:n
    if(~isempty(regexp(logs(i).name,'txt$','ONCE')) && ~isempty(regexp(logs(i).name,'^Final','ONCE')))
        logId = logs(i).name(18:end-4);
        
        disp(['Trajectory Id: ' logId]);
        
        initialTrajectory =                         loadTrajectory(['logs\Initial_Trajectory_' logId '.txt']);
        [trajectory, dt, f, exitflag, iterations, funevals] = loadTrajectory(['logs\Final_Trajectory_' logId '.txt']);
        
        disp(['objective function value: ' num2str(f)]);
        
        if(display)
            open(['logs\Initial_Trajectory_' logId '.fig']);
            initialFigure = gcf();
            open(['logs\Final_Trajectory_' logId '.fig']);
            finalFigure = gcf();
            open(['logs\state_' logId '.fig']);
            stateFigure = gcf();
        end
        
        f0 = 'fVal';                v0 = f;
        f1 = 'initialTrajectory';   v1 = initialTrajectory;
        f2 = 'finalTrajectory';     v2 = trajectory;
        f3 = 'exitflag';            v3 = exitflag;
        f4 = 'iterations';          v4 = iterations;
        f5 = 'funevals';            v5 = funevals;
        
        if(display)
            f6 = 'initialFigure';       v6 = initialFigure;
            f7 = 'finalFigure';         v7 = finalFigure;
            f8 = 'stateFigure';         v8 = stateFigure;
            
            trajectoryInfo(j) = struct(f0,v0, f1,v1, f2,v2, f3,v3, f4,v4, f5,v5, f6,v6, f7,v7, f8,v8);
        else
            trajectoryInfo(j) = struct(f0,v0, f1,v1, f2,v2, f3,v3, f4,v4, f5,v5);
        end
        fAll(j) = f;
        
        j = j+1;
    end
end

%% Find minimum

%locate minimum
[fMin, indexMin] = min(fAll);

% locate 2nd minimum
fAll(indexMin) = inf;
[fMin2, indexMin2] = min(fAll);




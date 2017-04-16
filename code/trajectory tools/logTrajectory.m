function logTrajectory(fileName, trajectory, parameters, exitflag, iterations, funevals)

%% Evaluate trajectory
[~,n] = size(trajectory);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

xState = trajectoryToVector(trajectory);
f = fObjectiveTrajectory(xState, parameters);
h = hConstraintsTrajectory(xState, parameters);

%% Define format for logging
float4 = '%.6e\t';

formatSpecTitle = [ fileName    '\n\r'];
formatSpecHeaders=[ 'time\t'    'x\t'       'y\t'	'heading\t' 'roll\t'    'roll rate\t'   'f(x*)\t'   'hmax(x*)\t'    'exitflag'      'iterations'    'functionEvaluations'   '\n\r'];
formatSpec1 = [     '%d\t'      float4      float4  float4      float4      float4          float4      float4          '%d\t'          '%d\t'          '%d\t'                  '\n\r'];
formatSpec3 = [     '%d\t'      float4      float4  float4      float4      float4          '\t'        '\t'            '\t'            '\t'            '\t'                    '\n\r'];

%% Log
global trajName
fileName = ['logs\' trajName '.txt'];
fid=fopen(fileName,'w');
fprintf(fid, formatSpecTitle);
fprintf(fid, formatSpecHeaders);

t = 0;
fprintf(fid, formatSpec1, t, x(1), y(1), heading(1), roll(1), rollRate(1), f(1), max(h), exitflag, iterations, funevals);
for i=2:n
    t = t + parameters.dt;
    fprintf(fid, formatSpec3, t, x(i), y(i), heading(i), roll(i), rollRate(i));
end

fclose(fid);

end
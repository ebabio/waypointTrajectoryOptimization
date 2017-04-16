function [trajectory, dt, f, exitflag, iterations, funevals] = loadTrajectory(fileName)
%% Define format for logging
float4 = '%.6e\t';

% formatSpecTitle = [ fileName    '\n\r'];
% formatSpecHeaders=[ 'time\t'    'x\t'       'y\t'	'heading\t' 'roll\t'    'roll rate\t'   'f(x*)\t'   'hmax(x*)\t'    'exitflag'      'iterations'    'functionEvaluations'   '\n\r'];
% formatSpec1 = [     '%d\t'      float4      float4  float4      float4      float4          float4      float4          '%d\t'          '%d\t'          '%d\t'                  '\n\r'];
% formatSpec3 = [     '%d\t'      float4      float4  float4      float4      float4          '\t'        '\t'            '\t'            '\t'            '\t'                    '\n\r'];


%% Load data
fid=fopen(fileName,'r');

fgets(fid);
fgets(fid);

i=1;
string = fgets(fid);
cell = strsplit(string,'\t');
num = str2double(cell);
trajectory(i,:) = num(1:6);
f = num(7);
exitflag = num(9);
iterations = num(10);
funevals = num(11);
while(1)
    i = i+1;
    string = fgets(fid);
    if(string==-1)
%         display('end of file reached');
        break;
    else
        cell = strsplit(string,'\t');
        num = str2double(cell);
        trajectory(i,:) = num(1:6);
    end
    
end

fclose(fid);

dt = trajectory(2,1);

trajectory = trajectory(:,2:6)';

end
function plotTrajectory(trajectory, dt, plots, log)

global trajName
%% Handle inputs
[m, n] = size(trajectory);

x = trajectory(1,:);
y = trajectory(2,:);
heading = trajectory(3,:);
roll = trajectory(4,:);
rollRate = trajectory(5,:);

t = 0 : dt : dt*(n-1);
%% Plot trajectory

if(plots<=1)
    figure()
    plot(y,x,'-x')
    axis equal
    cf = gcf();
    plotConstraints(cf.Number);
    
    if(log)
        fileName = ['logs\' trajName];
        saveas(cf.Number,fileName);
    end
end

if(plots>=1)
    figure()
    plot(t,roll,'b-x');
    hold on
    plot(t,rollRate,'r-x');
    hold off
    cf = gcf();
    plotConstraints(cf.Number);
    if(log)
        trajId = trajName(18:end);
        fileName = ['logs\state_'  trajId];
        saveas(cf.Number,fileName);
    end
end

end
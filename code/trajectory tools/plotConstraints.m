function plotConstraints(figureId)

nPoints = 300;

figure(figureId)
ax = gca();

xLimit = ax.XLim;
yLimit = ax.YLim;

deltaX = xLimit(2)-xLimit(1);
deltaY = yLimit(2)-yLimit(1);


x = xLimit(1):deltaX/(nPoints-1):xLimit(2);
y = yLimit(1):deltaY/(nPoints-1):yLimit(2);

[X,Y] = meshgrid(x,y);
Z = zeros(nPoints);

for i = 1:nPoints
    for j = 1:nPoints
        traj = [Y(i,j); X(i,j); 0; 0; 0];
        Z(i,j) = sum(max(gNoFlyConstraints(traj),0));
    end
end

Z = double(Z > 0.5);
hold on
contour(X,Y,Z);
colormap(bone(2));
hold off




end
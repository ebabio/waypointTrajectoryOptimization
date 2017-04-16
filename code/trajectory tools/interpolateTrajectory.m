function [trajectoryOutput, dt] = interpolateTrajectory(trajectoryInput, dt, interpFactor)

%% Handle inputs
[m, n] = size(trajectoryInput);

%% Interpolate
nOfElements = ((interpFactor+1)*(n-1)+1);
knownIndexes = (1 : (interpFactor+1) : nOfElements);

dt = dt * n / nOfElements;

trajectoryOutput = zeros(m, nOfElements);
trajectoryOutput(:,knownIndexes) = trajectoryInput;

for i=1:nOfElements
    % Detect if already known
    equalToIndex = (knownIndexes == i);
    k = find(equalToIndex,1,'first');
    if(k)
        continue
    end
    
    % Detect closes greater/smaller index
    greaterIndex = (knownIndexes > i);
    k = find(greaterIndex,1,'first');
    kGreat = knownIndexes(k);
    lesserIndex = (knownIndexes < i);
    k = find(lesserIndex,1,'last');
    kLess = knownIndexes(k);

    
    trajectoryOutput(:,i) = (kGreat-i)/(kGreat-kLess) .* trajectoryOutput(:,kLess) + (i-kLess)/(kGreat-kLess) .* trajectoryOutput(:,kGreat);
end

end
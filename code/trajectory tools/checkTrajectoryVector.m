function valid = checkTrajectoryVector(x)

valid = 1;

%% Check input validity

if(nargin ~= 1)
    error('error 1: wrong number of inputs');
end

if(size(size(x),2) ~= 2)
    error('error 2: input must be a matrix (2D array)')
end

[m, n] = size(x);
if(m ~= 1 && n ~= 1)
    error('error 3: input must be a either a row or column vector')
else
    l = m*n;
end

if(mod(l,5) ~= 0)
    error('error 4: input vector must have size multiple of 5');
end

end
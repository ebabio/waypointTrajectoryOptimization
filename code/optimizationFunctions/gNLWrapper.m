function [g, h] = gNLWrapper(gFun, hFun, x)

if(~isempty(gFun))
    g = gFun(x);
else
    g = [];
end

if(~isempty(hFun))
    h = hFun(x);
else
    h = [];
end

end

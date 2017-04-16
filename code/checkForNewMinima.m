function new = checkForNewMinima(fNew, reset)

persistent fOld
if(reset)
    fOld=[];
    return
end

new = 1;
for i=1:numel(fOld)
    ratio = fNew / fOld(i);
    
    if(ratio > .98 && ratio < 1.02)
        new = 0;
        break
    end    
end

if(new)
    fOld = [fOld fNew];
end

end




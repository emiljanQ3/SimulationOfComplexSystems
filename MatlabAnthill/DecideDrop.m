function [willDrop, dropPos] = DecideDrop(ant, world, C)
    
    willDrop = rand < C.P_d;
    
    if ~willDrop
        dropPos = [NaN, NaN];
       return 
    end
    
    [xs, ys] = AntPerceptionArea(ant);
    
    indices = 1:length(xs);
    emptyIndices = indices(~world.sand(xs, ys));
    
    randSandIndex = emptyIndices(rand*length(emptyIndices));
    
    dropPos = [xs(randSandIndex), ys(randSandIndex)];
end
function [willDrop, dropPos] = DecideDrop(ant, world, C)
    
    willDrop = rand < C.P_d;
    
    if ~willDrop
        dropPos = [NaN, NaN];
        return 
    end
    
    [xs, ys] = AntPerceptionArea(ant);
    
    indices = 1:length(xs);
    xys = sub2ind(world.size, xs, ys);
    emptyIndices = indices(~world.sand(xys) & ~world.antSpace(xys));
    
    if isempty(emptyIndices)
        dropPos = [NaN, NaN];
        willDrop = false;
        return
    end
    
    randSandIndex = emptyIndices(ceil(rand*length(emptyIndices)));
    
    dropPos = [xs(randSandIndex), ys(randSandIndex)];
end
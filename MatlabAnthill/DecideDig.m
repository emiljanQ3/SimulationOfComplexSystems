function [willDig, digPos] = DecideDig(ant, world, C)
    [perceptionXs, perceptionYs] = AntPerceptionArea(ant);
    perceptionXYs = sub2ind(world.size, perceptionXs, perceptionYs);
    [bodyXs, bodyYs] = AntBodyArea(ant);
    bodyXYs = sub2ind(world.size, bodyXs, bodyYs);
    
     isInDepression = sum(world.sand(perceptionXYs)) > 11;
     
     Q = mean(world.digPheromone(bodyXYs)); %Mean pheromone level
     
     if isInDepression
         willDig = rand < C.f_sa;
         willDig = willDig || rand < C.f_pa(Q);
     else
         willDig = rand < C.f_sa;
         willDig = willDig || rand < C.f_pa(Q);
     end
     
     %TODO how to decide dig position? Will do random block based on
     %movement matrix
     
    W = C.directionWeights;
    random = rand * sum(W);
    weightSum = 0;

    for relDir = 1:8
        weightSum = weightSum + W(relDir);
        if random < weightSum
            absDir = relDir - 1 + ant.direction;
            if absDir > 8
                movePos = ant.pos + C.directions{absDir - 8};
            else
                movePos = ant.pos + C.directions{absDir};
            end
            break
        end
    end
    
    dummyAnt.direction = absDir;
    dummyAnt.pos = movePos;
    
    [digAreaX, digAreaY] = AntBodyArea(dummyAnt);
    
    indices = 1:length(digAreaX);
    isSandIndex = false(1,length(digAreaX));
    for i = indices
        isSandIndex(i) = world.sand(digAreaX(i), digAreaY(i));
    end
    sandIndices = indices(isSandIndex);
    
    if(isempty(sandIndices))
       willDig = false;
       digPos = [NaN, NaN];
       return
    end
    
    randSandIndex = sandIndices(ceil(rand*length(sandIndices)));
    
    digPos = [digAreaX(randSandIndex), digAreaY(randSandIndex)];
     
end
function [willDig, digPos] = DecideDig(ant, world, C)
    [perceptionXs, perceptionYs] = AntPerceptionArea(ant);
    [bodyXs, bodyYs] = AntBodyArea(ant);
    
     isInDepression = sum(world.sand(perceptionXs, perceptionYs)) > 11;
     
     Q = mean(world.digPheromone(bodyXs, bodyYs)); %Mean pheromone level
     
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
            absDir = relDir + 1 - ant.direction;
            movePos = ant.pos + C.directions{absDir};
            break
        end
    end
    
    dummyAnt.direction = absDir;
    dummyAnt.pos = movePos;
    
    [digAreaX, digAreaY] = AntBodyArea(dummyAnt);
    
    indices = 1:length(digAreaX);
    sandIndices = indices(world.sand(digAreaX, digAreaY));
    
    randSandIndex = sandIndices(rand*length(sandIndices));
    
    digPos = [digAreaX(randSandIndex), digAreaY(randSandIndex)];
     
end
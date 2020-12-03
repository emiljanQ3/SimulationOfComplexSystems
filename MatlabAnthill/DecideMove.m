function [movePos, newDir] = DecideMove(ant, world, C)
    W = C.directionWeights;
    for relDir = 1:8
        % relDir is relative direction, absDir is absolute
        absDir = relDir + 1 - ant.direction;
        [dirX,dirY] = DirectionalArea(absDir);
        Q = mean(world.trailPheromone(dirX,dirY));
        W(relDir) = W(relDir) + Q;
        
        testAnt.direction = absDir;
        testAnt.pos = ant.pos + C.directions(absDir);
        [bodyX, bodyY] = AntBodyArea(testAnt);
        
        if IsBlocked(bodyX,bodyY,world)
           W(relDir) = 0; 
        end
    end
    
    random = rand * sum(W);
    weightSum = 0;
    
    for relDir = 1:8
        weightSum = weightSum + W(relDir);
        if random < weightSum
            newDir = relDir + 1 - ant.direction;
            movePos = ant.pos + C.directions(newDir);
            return
        end
    end
    
    movePos = ant.pos;
    newDir = ant.direction;
end
function [movePos, newDir] = DecideMove(ant, world, C)
    W = C.directionWeights;
    for relDir = 1:8
        % relDir is relative direction, absDir is absolute
        absDir = mod(relDir - 2 + ant.direction, 8) + 1;
        
        [dirX,dirY] = DirectionalArea(absDir);
        index = sub2ind(world.size, dirX+ant.pos(1), dirY+ant.pos(2));
        Q = mean(world.trailPheromone(index));
        W(relDir) = W(relDir) + Q;
        
        testAnt.direction = absDir;
        testAnt.pos = ant.pos + C.directions{absDir};
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
            newDir = mod(relDir - 2 + ant.direction, 8) + 1;
            movePos = ant.pos + C.directions{newDir};
            return
        end
    end
    
    movePos = ant.pos;
    newDir = ant.direction;
end
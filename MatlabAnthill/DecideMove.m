function [movePos, newDir] = DecideMove(ant, world, C, usePheromones)
    W = C.directionWeights;
    dirs = randperm(8);
    
    isAlongWall = zeros(1,8);
    for relDir = dirs
        % relDir is relative direction, absDir is absolute
        absDir = mod(relDir - 2 + ant.direction, 8) + 1;
        
        [dirX,dirY] = DirectionalArea(absDir);
        index = sub2ind(world.size, dirX+ant.pos(1), dirY+ant.pos(2));
        if usePheromones
            Q = mean(world.trailPheromone(index));
            W(relDir) = W(relDir) + Q;
        end
        
        testAnt.direction = absDir;
        testAnt.pos = ant.pos + C.directions{absDir};
        [bodyX, bodyY] = AntBodyArea(testAnt);
        if IsBlocked(bodyX,bodyY,world, C)
           W(relDir) = 0; 
        else
            [perceivedX,perceivedY] = AntPerceptionArea(testAnt);
            isAlongWall(relDir) = sum(world.sand(perceivedX,perceivedY),'all') > 0;
        end
    end
    W = W ./ sum(W);    
    random = rand * sum(W);
    weightSum = 0;
    
    dirsAlongWall = find(isAlongWall);
    if ~isempty(dirsAlongWall)
        dirsNotAlongWall = find(~isAlongWall);

        sumWAlongWall = sum(W(dirsAlongWall));
        sumWNotAlongWall = sum(W(dirsNotAlongWall));

        alongWallFactor = 0.98/sumWAlongWall;
        notAlongWallFactor = 0.02/sumWNotAlongWall;

        W(dirsAlongWall) = W(dirsAlongWall) * alongWallFactor;
        W(dirsNotAlongWall) = W(dirsNotAlongWall) * notAlongWallFactor;
    end  
            
    for relDir = dirs
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

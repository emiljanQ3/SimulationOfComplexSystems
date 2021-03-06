function [world, ants, antsPosAtT] = AntActions(ants, world, C)
    order = randperm(length(ants));
    
    antsPosAtT = zeros(length(ants),2); 
    
    for i = order
        ant = ants(i);
        antsPosAtT(i,:) = ant.pos;
        if ant.digTimer <= 0 && ~ant.hasPellet
            [willPickUp, pickUpPos] = DecidePickUp(ant, world, C);
            if willPickUp
                world.pellets(pickUpPos(1), pickUpPos(2)) = ...
                    world.pellets(pickUpPos(1), pickUpPos(2)) -1;
                ant.hasPellet = true;
                ant.carryTime = 0;
                ants(i) = ant;
                continue
            end
            
            [willDig, digPos] = DecideDig(ant, world, C);
            if willDig
                ant.digTimer = C.T_d;
                ant.digPos = digPos;
                world.sand(digPos(1), digPos(2)) = false;
                ants(i) = ant;
                continue
            end
        end
        
        if ant.digTimer > 0
            ant.digTimer = ant.digTimer - 1;
            
            digX = [ant.pos(1), ant.digPos(1)];
            digY = [ant.pos(2), ant.digPos(2)];
            digXY = sub2ind(world.size, digX, digY);
            world.digPheromone(digXY) = ...
                world.digPheromone(digXY) + C.Q_d; 
            
            if ant.digTimer <= 0
                ant.hasPellet = true;
            end
            ants(i) = ant;
            continue
        end
        
        if ant.hasPellet
            ant.carryTime = ant.carryTime + 1;
            Q_t = max(0, C.Q_t0 - (C.F * ant.carryTime)); %I'm assuming Q_t >= 0
            
            world.trailPheromone(ant.pos(1), ant.pos(2)) = ...
                world.trailPheromone(ant.pos(1), ant.pos(2)) + Q_t; 
            
            [willDrop, dropPos] = DecideDrop(ant, world, C);
            if willDrop
                ant.hasPellet = false;
                world.pellets(dropPos(1), dropPos(2)) = ...
                    world.pellets(dropPos(1), dropPos(2)) + 1;
                ants(i) = ant;
                continue
            end
        end
        
        %Move
        [oldBodyX, oldBodyY] = AntBodyArea(ant);
        oldBodyXYs = sub2ind(world.size, oldBodyX, oldBodyY);
        world.antSpace(oldBodyXYs) = ...
            world.antSpace(oldBodyXYs) - 1;
        
        usePheromones = ~ant.hasPellet;
        [movePos, newDir] = DecideMove(ant, world, C, usePheromones);
        
        %Check for ants to close to the edge
        if movePos(1) > size(world.sand, 1)-5 ...
                || movePos(1) < 5 ...
            || movePos(2) > size(world.sand, 2)-5 ...
                || movePos(2) < 5
            
            [newBodyX, newBodyY] = AntBodyArea(ant);
            newBodyXYs = sub2ind(world.size, newBodyX, newBodyY);
            world.antSpace(newBodyXYs) = ...
            world.antSpace(newBodyXYs) + 1;
            ants(i) = ant;
            continue
        end
        
        
        
        ant.pos = movePos;
        ant.direction = newDir;
        
        [newBodyX, newBodyY] = AntBodyArea(ant);
        newBodyXYs = sub2ind(world.size, newBodyX, newBodyY);
        world.antSpace(newBodyXYs) = ...
            world.antSpace(newBodyXYs) + 1;
        
        ants(i) = ant;
    end
    
end
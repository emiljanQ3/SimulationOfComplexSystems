function [world, ants] = AntActions(ants, world, C)
    order = randperm(1:length(ants));
    
    for i = order
        ant = ants(i);
        
        if ant.digtimer <= 0 && ~ant.hasPellet
            [willPickUp, pickUpPos] = DecidePickUp(ant, world, C);
            if willPickUp
                world.pellets(pickUpPos(1), pickUpPos(2)) = ...
                    world.pellets(pickUpPos(1), pickUpPos(2) -1);
                ant.hasPellet = true;
                ant.carryTime = 0;
                ants(i) = ant;
                continue
            end
            
            [willDig, digPos] = DecideDig(ant, world, C);
            if willDig
                ant.digTimer = C.T_d;
                ant.digPos = digPos;
                ants(i) = ant;
                continue
            end
        end
        
        if ant.digTimer > 0
            ant.digTimer = ant.digTimer - 1;
            
            [digX, digY] = AntBodyArea(ant); %Pheromone only at center of mass or entire body?
            digX = [digX, ant.digPos(1)];
            digY = [digY, ant.digPos(2)];
            world.didPheromone(digX, digY) = ...
                world.digPheromone(digX, digY) + C.Q_d; 
            
            if ant.digtimer <= 0
                world.sand(ant.digPos(1), ant.digPos(2)) = false;
                ant.hasPellet = true;
            end
            ants(i) = ant;
            continue
        end
        
        if ant.hasPellet
            ant.carryTime = ant.carryTime + 1;
            Q_t = max(0, C.Q_t0 - (C.F * ant.carryTime)); %I'm assuming Q_t >= 0
            
            [trailX, trailY] = AntBodyArea(ant); %Trail only at center of mass or entire body?
            world.trailPheromone(trailX, trailY) = ...
                world.trailPheromone(trailX, trailY) + Q_t; 
            
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
        [movePos, newDir] = DecideMove(ant, world, C);
        
        [oldBodyX, oldBodyY] = AntBodyArea(ant);
        world.antSpace(oldBodyX, oldBodyY) = ...
            world.antSpace(oldBodyX, oldBodyY) - 1;
        
        ant.pos = movePos;
        ant.direction = newDir;
        
        [newBodyX, newBodyY] = AntBodyArea(ant);
        world.antSpace(newBodyX, newBodyY) = ...
            world.antSpace(newBodyX, newBodyY) + 1;
        
        ants(i) = ant;
    end
    
end
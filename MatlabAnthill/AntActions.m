function [world, ants] = AntActions(ants, world, C)
    order = randperm(1:length(ants));
    
    %TODO apply pheromones
    for i = order
        ant = ants(i);
        
        if ant.digtimer <= 0 && ~ant.hasPellet
            [willPickUp, pickUpPos] = DecidePickUp(ant, world, C); %TODO implement
            if willPickUp
                world.pellets(pickUpPos(1), pickUpPos(2)) = ...
                    world.pellets(pickUpPos(1), pickUpPos(2) -1);
                ant.hasPellet = true;
                ants(i) = ant;
                continue
            end
            
            [willDig, digPos] = DecideDig(ant, world, C); %TODO implement
            if willDig
                ant.digTimer = C.T_d - 1;
                ant.digPos = digPos;
                ants(i) = ant;
                continue
            end
        end
        
        if ant.digTimer > 0
            ant.digTimer = ant.digTimer - 1;
            if ant.digtimer <= 0
                world.sand(ant.digPos(1), ant.digPos(2)) = false;
                ant.hasPellet = true;
            end
            ants(i) = ant;
            continue
        end
        
        if ant.hasPellet
            [willDrop, dropPos] = DecideDrop(ant, world, C); %TODO implement
            if willDrop
                ant.hasPellet = false;
                world.pellets(dropPos(1), dropPos(2)) = ...
                    world.pellets(dropPos(1), dropPos(2)) + 1;
                ants(i) = ant;
                continue
            end
        end
        
        %Move
        [movePos, newDir] = DecideMove(ant, world, C); %TODO implement
        
        [oldBodyX, oldBodyY] = AntBodyArea(ant);
        world.antSpace(oldBodyX, oldBodyY) = world.antSpace(oldBodyX, oldBodyY) - 1;
        
        ant.pos = movePos;
        ant.direction = newDir;
        
        [newBodyX, newBodyY] = AntBodyArea(ant);
        world.antSpace(newBodyX, newBodyY) = world.antSpace(newBodyX, newBodyY) + 1;
        
        ants(i) = ant;
    end
    
end
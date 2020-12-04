function [world, ants] = CreateAnts(numAnts, world)
    for i = 1:numAnts
        
        ant.digPos = [NaN, NaN];
        ant.carryTime = NaN;
        ant.digTimer = 0;
        ant.hasPellet = false;
        ant.direction = ceil(rand*8); % on unit circle, 1=0, 2=pi/4, 3=pi/2,...,8=7pi/4
        
        while true
            ant.pos = 5+ceil(rand(1,2) .* (size(world.sand)-10));
            [xs,ys] = AntBodyArea(ant);
            xys = sub2ind(world.size, xs, ys);
            if all(~world.sand(xys))
                break
            end
        end
        %Hope this does not cause to many overlapping ants, will have to
        %create extra check in that case.
        
        world.antSpace(xys) = world.antSpace(xys) + 1;
        
        ants(i) = ant;
    end
end
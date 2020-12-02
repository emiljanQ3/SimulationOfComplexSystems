function ants = CreateAnts(numAnts, world)
    for i = 1:numAnts
        
        ant.digPos = [NaN, NaN];
        ant.carryTime = NaN;
        ant.digTimer = 0;
        ant.hasPellet = false;
        ant.direction = ceil(rand*8); % on unit circle, 1=0, 2=pi/4, 3=pi/2,...,8=7pi/4
        
        while true
            ant.pos = ceil(rand(1,2) .* size(world));
            [xs,ys] = AntBodyArea(ant);
            if all(~world.sand(xs, ys))
                break
            end
        end
        ants(i) = ant;
    end
end
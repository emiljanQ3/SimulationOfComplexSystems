function ants = CreateAnts(numAnts, world)
    for i = 1:numAnts
        ant.digTimer = 0;
        ant.hasPellet = false;
        ant.direction = ceil(rand*8);
        ant.digPos = [NaN, NaN];
        
        while true
            ant.pos = ceil(rand(1,2)) .* size(world);
            if ~world.sand(ant.pos(1), ant.pos(2))
                break
            end
        end
        ants(i) = ant;
    end
end
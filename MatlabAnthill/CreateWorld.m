function world = CreateWorld(worldSize, diskR)
    world.sand = false(worldSize);
    for i = 1:worldSize
        for j = 1:worldSize
            world.sand(i,j) = norm([i,j] - worldSize./2) < diskR;
        end
    end
    
    world.antSpace = zeros(worldSize);
    world.pellets = zeros(worldSize);
    world.digPheromone = zeros(worldSize);
    world.trailPheromone = zeros(worldSize);
    world.size = worldSize;
end
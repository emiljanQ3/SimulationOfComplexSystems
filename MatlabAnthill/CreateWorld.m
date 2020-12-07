function world = CreateWorld(worldSize, diskR)
    [X,Y] = meshgrid(1:worldSize(1), 1:worldSize(2));
    
    world.disk = (X - worldSize(1)/2).^2 + (Y - worldSize(2)/2).^2 < diskR^2;
    
    world.sand = world.disk;
    world.antSpace = zeros(worldSize);
    world.pellets = zeros(worldSize);
    world.digPheromone = zeros(worldSize);
    world.trailPheromone = zeros(worldSize);
    world.size = worldSize;
end
function world = PheromoneDecay(world, C)
    world.trailPheromone = world.trailPheromone .* C.mu_t;
    world.digPheromone = world.digPheromone .* C.mu_d;
end
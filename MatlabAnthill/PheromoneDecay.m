function world = PheromoneDecay(world, C)
    world.digPheromone = world.digPheromone * C.decay_d;
    world.trailPheromone = world.trailPheromone * C.decay_t;
end
function world = PheromoneDiffuse(world, C)
    world.digPheromone = Diffuse(world.digPheromone, C.D_d);
    world.trailPheromone = Diffuse(world.trailPheromone, C.D_t);
end
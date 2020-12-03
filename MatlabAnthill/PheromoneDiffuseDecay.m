function world = PheromoneDiffuseDecay(world,C)
    for i = 1:size(world.sand,1)
        for j = 1:size(world.sand,2)
            numDigDiffusions = 0;
            numTrailDiffusions = 0;
            for k = 1:8
                neighbor = [i + searchI(k), j + searchJ(k)];
                if sum(neighbor > 0) == 2 && sum(neighbor <= 100) == 2 % neighbor is in world
                    if world.digPheromone(i,j) > world.digPheromone(neighbor) 
                        numDigDiffusions = numDigDiffusions + 1;
                        world.digPheromone(neighbor) = world.digPheromone(neighbor) + world.digPheromone(i,j) * C.D_d;
                    end
                    if world.trailPheromone(i,j) > world.trailPheromone(neighbor)
                        numTrailDiffusions = numTrailDiffusions + 1;
                        world.trailPheromone(neighbor) = world.trailPheromone(neighbor) + world.trailPheromone(i,j) * C.D_t;
                    end
                end
                                                                % decay         diffuse    
            newDigPheromoneLvl = world.digPheromone(i,j) * (1 - 1/C.mu_d - numDigDiffusions * C.D_d);
            newTrailPheromoneLvl =  world.trailPheromone(i,j) * (1 - 1/C.mu_t - numTrailDiffusions * C.D_t);
            world.digPheromone(i,j) = newDigPheromoneLvl * (newDigPheromoneLvl > 0);
            world.trailPheromone(i,j) = newTrailPheromoneLvl * (newTrailPheromoneLvl > 0);
            end
        end
    end
end


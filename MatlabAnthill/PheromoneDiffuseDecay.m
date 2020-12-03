function world = PheromoneDiffuseDecay(world,C)
    searchI = [-1 -1 -1  0 0  1 1 1];
    searchJ = [-1  0  1 -1 1 -1 0 1];
    sizeX = size(world.sand,1);
    sizeY = size(world.sand,2);
    numDigDiffusions = zeros(sizeX,sizeY);
    numTrailDiffusions = zeros(sizeX,sizeY);
    digDiffusions = zeros(sizeX,sizeY);
    trailDiffusions = zeros(sizeX,sizeY);
    
    % decay original values
    world.digPheromone = world.digPheromone * .5 ^ 1/C.digHalfLife;
    world.trailPheromone = world.trailPheromone * .5 ^ 1/C.trailHalfLife;
    
    for i = 1:sizeX
        for j = 1:sizeY
            for k = 1:8
                neighbor = [i + searchI(k), j + searchJ(k)];
                if sum(neighbor > 0) == 2 && sum(neighbor(1) <= sizeX + neighbor(2) <= sizeY) == 2 % neighbor is in world
                    if world.digPheromone(i,j) > world.digPheromone(neighbor) 
                        numDigDiffusions(i,j) = numDigDiffusions(i,j) + 1;
                        digDiffusions(neighbor) = digDiffusions(neighbor) + world.digPheromone(i,j) * C.D_d;
                    end
                    if world.trailPheromone(i,j) > world.trailPheromone(neighbor)
                        numTrailDiffusions(i,j) = numTrailDiffusions(i,j) + 1;
                        trailDiffusions(neighbor) = trailDiffusions(neighbor) + world.digPheromone(i,j) * C.D_d;
                    end
                end
            end
        end
    end
    % subtract losses from diffusion
    world.digPheromone = world.digPheromone  - world.digPheromone .* C.D_d .* numDigDiffusions;
    world.trailPheromone = world.trailPheromone - world.trailPheromone .* C.D_t .* numTrailDiffusions;
    % add gains from diffusion
    world.digPheromone = world.digPheromone + digDiffusions;
    world.trailPheromone = world.trailPheromone + trailDiffusions;
end


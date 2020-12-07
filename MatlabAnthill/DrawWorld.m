function DrawWorld(world, showPheromones)
    backgroundColor = [201, 199, 181]./255;
    sandColor = [204, 179, 90]./255;
    antColor = [13, 9, 3]./255;
    pelletColor = [143, 88, 6]./255;
    digColor = [1, 21, 148]./255;
    trailColor = [19, 194, 66]./255;
    
    digMax = 2000; %Tune to what seems reasonable.
    trailMax = 2000;
    

    figure(3)
    hold off
    rgb = zeros([world.size, 3]);

    for j = 1:3
        C = backgroundColor(j) .* ones(world.size); 
        C(world.pellets > 0) = pelletColor(j);
        C(world.antSpace > 0) = antColor(j);
        C(world.sand) = sandColor(j);
        rgb(:,:,j) = C;
    end

    imshow(rgb)
    
    if ~showPheromones
        return
    end
    
    %Overlay pheromones
    hold on
    
    digImg = ones([world.size, 3]) .* reshape(digColor, [1,1,3]);
    digPlot = imshow(digImg);
    set(digPlot, 'AlphaData', world.digPheromone/digMax)
   
    
    trailImg = ones([world.size, 3]) .* reshape(trailColor, [1,1,3]);
    trailPlot = imshow(trailImg);
    set(trailPlot, 'AlphaData', world.trailPheromone/trailMax)
end


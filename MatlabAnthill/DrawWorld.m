function DrawWorld(world)
    backgroundColor = [201, 199, 181]./255;
    sandColor = [204, 179, 90]./255;
    antColor = [13, 9, 3]./255;
    pelletColor = [143, 88, 6]./255;
    digColor = [1, 21, 148]./255;
    trailColor = [111, 1, 148]./255;
    
    digMax = 0.001;
    trailMax = 0.001;
    

    figure(3)
    hold off
    rgb = zeros([world.size, 3]);

    for j = 1:3
        C = backgroundColor(j) .* ones(world.size); 
        C(world.antSpace > 0) = antColor(j);
        C(world.sand) = sandColor(j);
        C(world.pellets > 0) = pelletColor(j);
        rgb(:,:,j) = C;
    end

    imshow(rgb)
    
    %Overlay pheromones
    hold on
    
    digImg = ones([world.size, 3]) .* reshape(digColor, [1,1,3]);
    digPlot = imshow(digImg);
    set(digPlot, 'AlphaData', world.digPheromone/digMax)
   
    
    trailImg = ones([world.size, 3]) .* reshape(trailColor, [1,1,3]);
    trailPlot = imshow(trailImg);
    set(trailPlot, 'AlphaData', world.trailPheromone/trailMax)
end


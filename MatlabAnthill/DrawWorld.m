function DrawWorld(world)
    backgroundColor = [201, 199, 181]./255;
    sandColor = [204, 179, 90]./255;
    antColor = [13, 9, 3]./255;
    pelletColor = [143, 88, 6]./255;
    digColor = [240, 210, 62]./255;
    trailColor = [240, 210, 62]./255;
    

    figure(3)
    
    rgb = zeros([world.size, 3]);

    for j = 1:3
        C = backgroundColor(j) .* ones(world.size);
        C(world.antSpace > 0) = antColor(j);
        C(world.sand) = sandColor(j);
        C(world.pellets > 0) = pelletColor(j);
        rgb(:,:,j) = C;
    end

    imshow(rgb)
    
end


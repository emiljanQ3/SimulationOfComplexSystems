function VisualizeLayer(world, showLayers)
%   Visualizes each layer of world according to the boolean array.
    names = fieldnames(world);
    figure(1); axis([0, length(world.sand), 0, length(world.sand)])
    for i = 1:length(names)
        if showLayers(i)
            subplot(1,length(names),i)
            image(getfield(world,names(i)))
        end
        
    end
end


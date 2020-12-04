function VisualizeLayer(world, ants, showLayers)
%   Visualizes each layer of world according to the boolean array.
% Q: what should showLayers input look like, and what does each element
% correspond to?
    names = fieldnames(world);
    figure(1); axis square; axis([0, length(world.sand), 0, length(world.sand)])
    tiledlayout(2,ceil(length(names)/2))
    for i = 1:length(names)-1
        nexttile
        if showLayers(i)
            A = getfield(world,names{i});
            image(500*A); hold on;
            for j = 1:length(ants)
                plot(ants(j).pos(1),ants(j).pos(2),'*r');
            end
        end
    end
end


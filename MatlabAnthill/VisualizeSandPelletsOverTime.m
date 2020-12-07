function VisualizeSandPelletsOverTime(snapshots)
    sand = zeros(1, length(snapshots));
    pelletsTot = sand;
    pelletsInside = sand;

    for i = 1:length(snapshots)
        world = snapshots{i};
        sand(i) = sum(world.sand, 'all');
        pelletsTot(i) = sum(world.pellets, 'all');
        pelletsInside(i) = sum(world.pellets(world.disk), 'all');
    end

    x = 1:length(snapshots);
    y1 = sand;
    y2 = sand + pelletsInside;
    y3 = sand + pelletsTot;

    figure(4)
    hold off
    plot(x, y1)
    hold on
    plot(x, y2)
    plot(x, y3)

    legend('Sand', 'Sand + pellets under disc', ...
        'Sand + all pellets', 'Location', 'southwest')
end


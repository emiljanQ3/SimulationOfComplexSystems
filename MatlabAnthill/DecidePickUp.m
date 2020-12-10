function [willPickUp, pickUpPos] = DecidePickUp(ant, world, C)
    [xs, ys] = AntPerceptionArea(ant);
    willPickUp = false;
    pickUpPos = [NaN, NaN];
    for i = 1:length(xs)
        if world.pellets(xs(i), ys(i)) > 0 ...
                && world.disk(xs(i), ys(i)) || C.willPickUpOutsideDisk ...
                && rand < C.P_p
            willPickUp = true;
            pickUpPos = [xs(i), ys(i)];
            break
        end
    end
end
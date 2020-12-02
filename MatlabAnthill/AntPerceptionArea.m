function [xs,ys] = AntPerceptionArea(ant)
    topFacingX = [-3,-3,-3,-3, -3:3 ,3,3,3,3];
    topFacingY = [-1:3, 3,3,3,3, 3:-1];
    topRightFacingX = [-3, -3:3, 3,3,3,3,3,3, 2];
    topRightFacingY = [2, 3,3,3,3,3,3, 3:-3, -3];
    
    if mod(ant.direction, 2) == 1
        k = (ant.direction - 1)/2 - 1;
        xs = rot90(verticalBodyX, k);       %rot90 function is wrong, replace
        ys = rot90(vertivalBodyY, k);
    else
        k = (ant.direction)/2 - 1;
        xs = rot90(verticalBodyX, k);
        ys = rot90(vertivalBodyY, k);
    end
    
    xs = reshape(xs, [1,numel(xs)]) + ant.pos(1);
    ys = reshape(ys, [1,numel(ys)]) + ant.pos(2);
end
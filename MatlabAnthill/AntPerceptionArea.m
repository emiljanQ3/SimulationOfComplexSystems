function [xs,ys] = AntPerceptionArea(ant)
% need to return the absolute xs and ys
    topFacingX = [-3,-3,-3,-3, -3:3 ,3,3,3,3];
    topFacingY = [-1:3, 3,3,3,3,3, 3:-1:-1];
    topRightFacingX = [-3, -3:3, 3,3,3,3,3,3, 2];
    topRightFacingY = [2, 3,3,3,3,3,3, 3:-1:-3, -3];
    
    if mod(ant.direction, 2) == 1
        k = (ant.direction - 1)/2 - 1;
        [xs, ys] = rot90n(topFacingX, topFacingY, k);  
    else
        k = (ant.direction)/2 - 1;
        [xs, ys] = rot90n(topRightFacingX, topRightFacingY, k); 
    end
    
    xs = reshape(xs, [1,numel(xs)]) + ant.pos(1);
    ys = reshape(ys, [1,numel(ys)]) + ant.pos(2);
end
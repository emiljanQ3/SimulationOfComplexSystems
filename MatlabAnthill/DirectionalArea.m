function [xs,ys] = DirectionalArea(dirIndex)
    rightX = [3,3,3];
    rightY = [-1:1];
    topRightX = [2,3,3];
    topRightY = [3,3,2];
    
    if mod(dirIndex, 2) == 1
        k = (dirIndex - 1)/2;
        [xs,ys ]= rot90n(rightX, rightY,k);
        
    else
        k = (dirIndex)/2 - 1;
        xs = rot90(topRightX, k);
        ys = rot90(topRightY, k);
    end
end


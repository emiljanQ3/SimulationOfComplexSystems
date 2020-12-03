function [xs,ys] = AntBodyArea(ant)
    [verticalBodyX, verticalBodyY] = meshgrid(-1:1, -2:2);
    diagonalBodyX = [1,2,0,1,2,-1,0,1,-2,-1,0,-2,-1];
    diagonalBodyY = [2,2,1,1,1,0,0,0,-1,-1,-1,-2,-2];
    
    if ant.direction == 1 || ant.direction == 5
        [xs, ys] = rot90n(verticalBodyX,verticalBodyY, -1);              
    elseif ant.direction == 3 || ant.direction == 7
        xs = verticalBodyX;
        ys = verticalBodyY;
    elseif ant.direction == 2 || ant.direction == 6
        xs = diagonalBodyX;
        ys = diagonalBodyY;
    else
        [xs, ys] = rot90n(diagonalBodyX,diagonalBodyY, 1);
    end
    
    xs = reshape(xs, [1,numel(xs)]) + ant.pos(1);
    ys = reshape(ys, [1,numel(ys)]) + ant.pos(2);
end


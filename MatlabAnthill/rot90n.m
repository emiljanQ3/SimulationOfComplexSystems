function [xRot, yRot] = rot90n(xMatrix, yMatrix, n)
    % rotate n times towards left if sign(n) > 0, else rotate right. 
    xRot = xMatrix * cos(n*pi/2) - yMatrix * sin(n*pi/2);
    yRot = xMatrix * sin(n*pi/2) + yMatrix * cos(n*pi/2);
end


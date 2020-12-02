clear all
numRotations = 3;

% orientation #1 - pointing to the right
oneX = [-3 -3 -3 -1 0 1 2 3 3 3 3 3 3 3 2 1 0 -1];
oneY = [-1 0 1 3 3 3 3 3 2 1 0 -1 -2 -3 -3 -3 -3 -3]; 

xPerimeter = [3 3 3 3 2 1 0 -1 -2 -3 -3 -3 -3 -3 -3 -3 -2 -1 0 1 2 3 3 3];
yPerimeter = [0 1 2 3 3 3 3 3 3 3 2 1 0 -1 -2 -3 -3 -3 -3 -3 -3 -3 -2 -1];
[tPerimeter,rPerimeter] = cart2pol(xPerimeter,yPerimeter);

subplot(2,1,1)
scatter(oneX,oneY,'filled')
title('Before')
xlim([-3 3])
ylim([-3 3])

[tOne, rOne] = cart2pol(oneX,oneY);
for i = 1:length(oneX)
    iPerimeter = find(tOne(i)==tPerimeter) + 3 * numRotations; % move it 3 * k units along the perimeter
    if iPerimeter > length(xPerimeter)
        iPerimeter = iPerimeter - length(xPerimeter);
    end
    tOne(i) = tPerimeter(iPerimeter);
    rOne(i) = rPerimeter(iPerimeter);
end
[x,y] = pol2cart(tOne,rOne);
subplot(2,1,2);
scatter(x,y,'filled')
title('After')
xlim([-3 3])
ylim([-3 3])

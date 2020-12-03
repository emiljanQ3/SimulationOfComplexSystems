function isBlocked = IsBlocked(bodyX,bodyY,world)
    
    for i = 1:length(bodyX)
        if world.sand(bodyX(i), bodyY(i)) ...
                || world.pellets(bodyX(i), bodyY(i)) > 0 ...
                || world.antSpace(bodyX(i), bodyY(i)) > 1
            isBlocked = true;
            return
        end
    end
    
    isBlocked = false;
end
function isBlocked = IsBlocked(bodyX,bodyY,world,C)
    
    for i = 1:length(bodyX)
        isBlockedByPellets = ~C.walkOverPellets && ...
            ( world.pellets(bodyX(i), bodyY(i)) > 0 ...
            && (world.disk(bodyX(i), bodyY(i)) ...
            || ~C.freeMoveOutsideDisk ));
        
        if world.sand(bodyX(i), bodyY(i)) ...
                ||  isBlockedByPellets ...
                || world.antSpace(bodyX(i), bodyY(i)) >= C.antDepth
            isBlocked = true;
            return
        end
    end
    
    isBlocked = false;
    
    % coltons edit
    %     if any(world.sand(bodyX,bodyY),'all') ...
%             || any(world.pellets(bodyX,bodyY),'all')...
%             || any(world.antSpace(bodyX,bodyY),'all')
%         isBlocked = true;
%         return
%     end
end

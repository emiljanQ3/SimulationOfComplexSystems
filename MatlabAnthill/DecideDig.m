function [willDig, digPos] = DecideDig(ant, world, C)
    [perceptionXs, perceptionYs] = AntPerceptionArea(ant);
    [bodyXs, bodyYs] = AntBodyArea(ant);
    
     isInDepression = sum(world.sand(perceptionXs, perceptionYs)) > 11;
     
     Q = mean(world.digPheromone(bodyXs, bodyYs)); %Mean pheromone level
     
     if isInDepression
         willDig = rand < C.f_sa;
         willDig = willDig || rand < C.f_pa(Q);
     else
         willDig = rand < C.f_sa;
         willDig = willDig || rand < C.f_pa(Q);
     end
     
     %TODO how to decide dig position? Will do random block based on
     %movement matrix
     
end
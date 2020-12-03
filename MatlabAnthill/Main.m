%Constants
worldSize = [10000, 10000];
diskR = 49;
numAnts = 100;
simTime = 60*60*5; %s

C.T_d = 42.04; %s
C.P_d = 0.188; %/s
C.P_p = 0.102; %/contact
C.P_sa = 0.054; 
C.P_sh = 2.83 * 10^-2; %/s
C.f_pa = @(X) X^2/(X^2 + 200);
C.f_ph = @(X) X^2/(X^2 + 3500);
C.Q_d = 100;
C.Q_t0 = 2000;
C.F = 5;
C.mu_t  = 40*60;
C.D_t = 3.322 *10^-7;
C.mu_d  = 20*60;
C.D_d = 3.322 *10^-7;
C.directions = {[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]}; %absolute
C.directionWeights = [100, 46, 6, 0, 1, 0, 6, 46]; %relative

%Initialize
world = CreateWorld(worldSize, diskR);
[world, ants] = CreateAnts(numAnts, world);
numTimeSteps = simTime; 

%Simulation
for i = 1:numTimeSteps  
    [world, ants] = AntActions(ants, world, C);
    world = PheromoneDecay(world, C);
    world = PheromoneDiffusion(world, C);
end

%Visualize

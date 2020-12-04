%Constants
worldSize = [300, 300];
diskR = 130;                         % cm
numAnts = 100;                       % leggy bois
simTime = 60*60*5;                  % s

C.T_d = 42.04;                      % s
C.P_d = 0.188;                      % /s
C.P_p = 0.102;                      % /contact
C.f_sa = 0.054;                     % /contact
C.f_sh = 2.83 * 10^-2;              % /s
C.f_pa = @(X) X.^2/(X.^2 + 200);    
C.f_ph = @(X) X.^2/(X.^2 + 3500);
C.Q_d = 100;                        % units
C.Q_t0 = 2000;                      % units
C.F = 5;
C.mu_t  = 40*60;                    % s
C.mu_d  = 20*60;                    % s
C.D_t = 3.322 *10^-7 * 1/0.08^2;    % cell^2/s
C.D_d = 3.322 *10^-7 * 1/0.08^2;    % cell^2/s
C.directions = {[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]}; %absolute
C.directionWeights = [100, 46, 6, 0, 1, 0, 6, 46]; %relative

%Initialize
world = CreateWorld(worldSize, diskR);
[world, ants] = CreateAnts(numAnts, world);
numTimeSteps = simTime; 

%Simulation
v = zeros(1,numTimeSteps);
for i = 1:numTimeSteps  
    DrawWorld(world);
    [world, ants] = AntActions(ants, world, C);
    world = PheromoneDiffuseDecay(world, C);
end

%Visualize

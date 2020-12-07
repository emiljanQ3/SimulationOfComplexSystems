%Constants
worldSize = [150, 150];
diskR = 70;                         % cells
numAnts = 30;                       % leggy bois
simTime = 60*60*24;                 % s
snapshotTime = 5*60;                % s

C.dt = 1;                           % s
C.T_d = 42.04 / C.dt;                    
C.P_d = 0.188 * C.dt;                    
C.P_p = 0.102;                      % /contact
C.f_sa = 0.054;                     % /contact
C.f_sh = 2.83 * 10^-2 * C.dt;            
C.f_pa = @(X) X.^2/(X.^2 + 200);    
C.f_ph = @(X) X.^2/(X.^2 + 3500);
C.Q_d = 100;                        % units
C.Q_t0 = 2000;                      % units
C.F = 5;                            % units
C.mu_t  = 40*60 / C.dt;                   
C.decay_t =  2^(-C.dt/C.mu_t);
C.mu_d  = 20*60 / C.dt;                 
C.decay_d =  2^(-C.dt/C.mu_d);
C.D_t = 3.322 *10^-7 * 1/0.08^2 * C.dt;    % cell^2
C.D_d = 3.322 *10^-7 * 1/0.08^2 * C.dt;    % cell^2
C.directions = {[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]}; %absolute
C.directionWeights = [100, 46, 6, 0, 1, 0, 6, 46]; %relative

%Initialize
world = CreateWorld(worldSize, diskR);
[world, ants] = CreateAnts(numAnts, world);
numTimeSteps = ceil(simTime / C.dt); 

snapshots = cell(1, ceil(numTimeSteps/(snapshotTime/C.dt)));

%Simulation
for i = 1:numTimeSteps  
    %DrawWorld(world, 0);
    [world, ants] = AntActions(ants, world, C);
    world = PheromoneDecay(world, C);
    world = PheromoneDiffuse(world, C);
    
    PrintProgress(i, numTimeSteps);
    snapshots = SaveSnapshots(snapshots, i, numTimeSteps, world);
end

%% Visualize

DrawWorld(world, 1)

DrawWorld(world, 0)

sand = zeros(1, length(snapshots));
pelletsTot = sand;
pelletsInside = sand;

for i = 1:length(snapshots)
    world = snapshots{i};
    sand(i) = sum(world.sand, 'all');
    pelletsTot(i) = sum(world.pellets, 'all');
    pelletsInside(i) = sum(world.pellets(world.disk), 'all');
end

x = 1:length(snapshots);
y1 = sand;
y2 = sand + pelletsInside;
y3 = sand + pelletsTot;

figure(4)
hold off
plot(x, y1)
hold on
plot(x, y2)
plot(x, y3)

clear all;
%Rule params
C.antDepth = 2; %
C.freeMoveOutsideDisk = false; %
C.willPickUpOutsideDisk = true;
C.walkOverPellets = true; %

%Constants
worldSize = [625, 625];
diskR = 125;                         % cells
numAnts = 50;                       % leggy bois <3
simTime = 60*60*27;                 % s
snapshotTime = 5*60;                % s

C.worldSize = worldSize;
C.diskR = diskR;
C.numAnts = numAnts;
C.simTime = simTime;
C.snapshotTime = snapshotTime;
C.dt = 1;                           % s
C.T_d = 42.04 / C.dt;                    
C.P_d = 0.188 * C.dt;                    
C.P_p = 0.102;                      % /contact
C.f_sa = 0.054;                     % /contact
C.f_sh = 2.83 * 10^-2 * C.dt;            
C.f_pa = @(X) X.^2/(X.^2 + 200^2);    
C.f_ph = @(X) X.^2/(X.^2 + 3500^2);
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

snapshots = cell(1, numTimeSteps / ceil(snapshotTime/C.dt));

antPositions = zeros(numAnts,2, numTimeSteps);

%%
%Simulation

k = 1;
for i = 1:numTimeSteps
    [world, ants, antPositions(:,:,i)] = AntActions(ants, world, C);
    world = PheromoneDecay(world, C);
    world = PheromoneDiffuse(world, C);

    PrintProgress(i, numTimeSteps);
    if mod(i,numTimeSteps/ceil(snapshotTime/C.dt)) == 0
        snapshots{k} = {world.antSpace, world.sand};
        k = k + 1;
    end
%     snapshots = SaveSnapshots(snapshots, i, numTimeSteps, world);
end
datenow = datestr(now);
datenow(datenow==':')='.';
save(string("AntPos_" + datenow + ".mat"), "antPositions",'-v7.3', '-mat')
save(string("SnapShots_" + datenow +".mat"), "snapshots",'-v7.3','-mat')
save(string("C_" + datenow +".mat"), "C",'-v7.3','-mat')

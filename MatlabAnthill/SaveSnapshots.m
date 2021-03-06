function snapshots = SaveSnapshots(snapshots, i, numTimeSteps, world)
    completion = i/numTimeSteps * length(snapshots);  %in percent
    if mod(completion, 1) <= 1/(numTimeSteps) || 1-mod(completion, 1) <= 1/(numTimeSteps)
        index = round(completion);
        snapshots{index} = world;
    end
end
function PrintProgress(i, numTimeSteps)
    completion = i/numTimeSteps * 100;  %in percent
    if mod(completion, 1) <= 1/(2*numTimeSteps)
        text = string(round(completion)) + "% completed.";
        disp(text);
        toc
        tic
    end
end
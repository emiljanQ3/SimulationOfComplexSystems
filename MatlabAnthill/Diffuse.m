function outQ = Diffuse(inQ, D)
    outQ = inQ * (1-8*D);
    
    %Diagonals
    outQ(1:end-1, 1:end-1) = outQ(1:end-1, 1:end-1) + D * inQ(2:end, 2:end);
    outQ(2:end, 2:end) = outQ(2:end, 2:end) + D * inQ(1:end-1, 1:end-1);
    
    outQ(2:end, 1:end-1) = outQ(2:end, 1:end-1) + D * inQ(1:end-1, 2:end);
    outQ(1:end-1, 2:end) = outQ(1:end-1, 2:end) + D * inQ(2:end, 1:end-1);
    
    %Rows/columns
    outQ(1:end, 1:end-1) = outQ(1:end, 1:end-1) + D * inQ(1:end, 2:end);
    outQ(1:end, 2:end) = outQ(1:end, 2:end) + D * inQ(1:end, 1:end-1);
    
    outQ(1:end-1, 1:end) = outQ(1:end-1, 1:end) + D * inQ(2:end, 1:end);
    outQ(2:end, 1:end) = outQ(2:end, 1:end) + D * inQ(1:end-1, 1:end);
end
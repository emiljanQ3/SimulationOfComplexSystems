numSamples = 7;
sum = 0;
for i = 1:numSamples
    load("500x500-r125-" + string(i))
    sum = sum + deltaSand;
end

mean = sum./numSamples;

doubleX = [12, 24, 46, 48, 58, 92, 97, 101, 106, 116, 174, 184, 213, 223];
tripleX = [194, 203, 233];
mean(doubleX) = mean(doubleX)./2;
mean(tripleX) = mean(tripleX)./3;

plot(linspace(1/12,30, length(mean)), mean)

xlabel("time in hours")
ylabel("number of pellets dug out per 5 minutes")

load("data.mat")

netDir = "nets\";

AR = 20;
SL = 4;

for yFeature = 1:12
    [net, xTrain, yTrain] = ...
        createNetwork(standardizedData, yFeature, AR, SL, "keepTraining", 0);
    
    [fileName] = saveNetToFile(netDir, net, SL);
    
    yTrain = cell2mat(yTrain);
    
    [yPred] = predictStuff(net, xTrain);
    
    figure
    hold on
    grid on
    
    % plot([1:21], yTrain(end-20:end))
    % plot([11:21], yPred)
    
    plot(yTrain)
    plot(yPred)
    
end










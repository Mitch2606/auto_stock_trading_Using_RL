function [net, average, best] = trainMany(LSTMUnits, sequenceLength, data, yFeature)
%TRAINMANY Summary of this function goes here
%   Detailed explanation goes here


nets = [];
RMSEs = [];

numNets = 25;

parfor i = 1: numNets
    %Evaluate the network
    [net, xTrain, yTrain] = ...
        createNetwork(data, yFeature, LSTMUnits, sequenceLength)
    
    yTrain = cell2mat(yTrain);
    
    inputData = xTrain(end - 50:end);
    
    [yPred] = predictStuff(net, inputData);
    
    %Calculate RMSE in only the predicted areas
    Error = yTrain(end-50:end) - yPred;
    RMSE = sqrt(mean(Error.^2));
    
    %Make lists of RMSE and Nets
    RMSEs = [RMSEs; RMSE];
    nets = [nets; {net}];
    
    fprintf("\n %2d / %2d | RMSE: %1.4f", i, numNets, RMSE)
end

[best, IndexOfBestNet] = min(RMSEs);
average = mean(RMSEs);

net = nets{IndexOfBestNet};

end


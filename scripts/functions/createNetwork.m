function [net, xTrain, yTrain] = createNetwork(datasets, yFeature, numHiddenUnits, sequenceLength, varargin)
%CREATENETWORK Summary of this function goes here
%   Detailed explanation goes here

keepTraining = 0;
for i = 1:2:length(varargin)
    parameter = lower(varargin{i});
    value = varargin{i + 1};
    
    switch(parameter)
        case("keeptraining") 
            keepTraining = value;
        otherwise
            disp("Damn shotie")
    end
end
    
numFeatures = length(datasets);

masterDataset = [];
for i = 1:numFeatures
    masterDataset = [masterDataset, datasets{i}(:,:)];
    
end
numFeatures = size(masterDataset,2);

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(1)
    regressionLayer];

trainWindows = slidingWindow(masterDataset, sequenceLength, 'dim', 1);
xTrain = permute(num2cell(trainWindows(:, :, 1:end-1), [1, 2]), [3 1 2]);
yTrain = num2cell(permute(trainWindows(end, yFeature, 2:end), [3, 1, 2]));

for i = 1:length(xTrain)
    xTrain{i} = transpose(xTrain{i});
end

options = trainingOptions('adam', ...
    'MaxEpochs',200,...
    'InitialLearnRate',0.1, ...
    'LearnRateSchedule', "piecewise",...
    'LearnRateDropFactor', 0.1,...
    'LearnRateDropPeriod', 10, ...
    'Verbose',1, ...
    'executionEnvironment', "gpu");

netfile = "nets\BestAR" + numHiddenUnits + "SL" + sequenceLength + ".mat";

if(keepTraining == 1)
    load(netfile)
    net = trainNetwork(xTrain(1:end-50), cell2mat(yTrain(1:end-50)), net.Layers, options);
elseif(isfile(netfile) == 1)
    load(netfile)
else
    net = trainNetwork(xTrain(1:end-50), cell2mat(yTrain(1:end-50)), layers, options);
end

end


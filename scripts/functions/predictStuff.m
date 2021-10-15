function [temp] = predictStuff(net, inputData)
%PREDICTSTUFF Summary of this function goes here
%   Detailed explanation goes here

temp = [];
for i = 1: length(inputData)
    prediction = predict(net, inputData{i});
    temp = [temp; prediction];
end


end


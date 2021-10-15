function [fileName] = saveNetToFile(netDir, net, SL)
%SAVENETTOFILE Summary of this function goes here
%   Detailed explanation goes here


LSTMUnits = net.Layers(2).NumHiddenUnits;
fileName = netDir + "BestAR" + LSTMUnits + "SL" + SL + ".mat";

save(fileName, 'net')


end


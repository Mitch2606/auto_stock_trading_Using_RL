function [actor] = makeActor(ObservationInfo, ActionInfo)
%MAKENET Summary of this function goes here
%   Detailed explanation goes here

layers = [
    sequenceInputLayer(6,"Name","input_1")
    fullyConnectedLayer(256,"Name","fc_1")
    reluLayer("Name","relu")
    fullyConnectedLayer(256,"Name","fc_body")
    tanhLayer("Name","tanh")
    lstmLayer(256,"Name","lstm_1")
    lstmLayer(256,"Name","lstm_2")
    fullyConnectedLayer(3,"Name","fc_action")
    softmaxLayer("Name","output")
    classificationLayer("Name","RepresentationLoss")];

actor = layerGraph(layers);




end


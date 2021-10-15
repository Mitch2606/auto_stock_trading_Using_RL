function [InitialObservation, LoggedSignal] = myResetFunction()

% figure

load("dataset\regularSet.mat")

% randNum = round(rand() * (size(sets,2)), 0);
randNum = 10;

% if(randNum == 0)
%     randNum = 1;
% end

data = flip(sets(:,randNum ));

save("dataset\oneLine.mat", 'data');

stuff = [0, 1, data(1), 0, 500, 0];

InitialObservation = stuff;

LoggedSignal.State = InitialObservation;








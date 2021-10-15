function [NextObs, Reward, IsDone, LoggedSignals] = moneyBasedReward(Action, LoggedSignals)
load("dataset\oneLine.mat");

State = LoggedSignals.State;

count = State(end - 4);

currentPrice = data(count);

previousChoice = State(1);
numShares = State(end - 2);
wallet = State(end  - 1);
boughtPrice = State(end);

%Determine the reward
if((Action == 1))          %Sell
    Reward = numShares * currentPrice;
    
    wallet = wallet + Reward;
    
    numShares = 0;
    
    choice = Action;
    
    boughtPrice = 0;
    
elseif((Action == 2)) %Buy
    Reward = - currentPrice;
    boughtPrice = currentPrice;
    wallet = wallet - currentPrice;
    
    numShares = numShares + 1;
    
    choice = Action;
elseif(Action == 3)                                            %Hold
    Reward = 0;
    
    choice = Action;
    
else
    Reward = -2;
    choice = 0;
end
%Iterate Count
count = count + 1;

if(previousChoice == Action)
    Reward = Reward - (numShares * 0.01);
end

fprintf("\n%2.2f | %4.0d | %2.4f | %3.2f | %3d | %2.4f | %2.4f" ,...
    Action, count, currentPrice, wallet, numShares, boughtPrice, Reward)
temp = [choice, count, currentPrice, numShares, wallet, boughtPrice];

currentPrice = data(count);
NextObs = temp;

%Log What we did and the values associated at each point
temp = [temp, NextObs];

LoggedSignals.State = [temp];
%Determine if the Bot Lost
if(wallet >= 2000)
    IsDone = 1;
    Failed = 0;
elseif(wallet <= 0)
    Failed = 1;
    IsDone = 1;
else
    Failed = 0;
    IsDone = 0;
end
    



end

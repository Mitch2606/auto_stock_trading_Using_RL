function [NextObs, Reward, IsDone, LoggedSignals] = actionBasedReward(Action, LoggedSignals)
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
    if((currentPrice > boughtPrice) && (boughtPrice ~= 0))
        Reward = numShares * 1;
    else
        Reward = (numShares + 1) * -0.01;
    end
    
    wallet = wallet + numShares * currentPrice;
    
    numShares = 0;
    
    choice = Action;
    
    boughtPrice = 0;
    
elseif((Action == 2)) %Buy

    Reward = 0.01;

    
    boughtPrice = currentPrice;
    wallet = wallet - currentPrice;
    
    numShares = numShares + 1;
    
    choice = Action;
elseif(Action == 3)                                            %Hold
    if((currentPrice > boughtPrice) && (boughtPrice ~= 0))
        Reward = numShares * 0.01;
    else
        Reward = (numShares + 1) * -0.01;
    end
    
    choice = Action;
    
else
    Reward = -2;
    choice = 0;
end

if(previousChoice == Action)
    Reward = Reward - (numShares * 0.01);
end

%Iterate Count
count = count + 1;


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

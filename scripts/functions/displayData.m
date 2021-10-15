function displayData(dataToDisplay)
%DISPLAYDATA Summary of this function goes here
%   Detailed explanation goes here

figure
numOfData = length(dataToDisplay);
for i = 1: numOfData
    subplot(numOfData, 1, i)
    hold on
    grid on
    plot(dataToDisplay{i});
    
    xlabel("Time (days)")
    ylabel("Price ($)")
    
end

end


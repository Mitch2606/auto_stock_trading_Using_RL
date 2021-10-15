
load("data.mat")

netDir = "nets\";
resultsDir = "resultsARSL\";

ARs = [10:10:20];
SLs = [2:2:24];

yFeature = 2;

figure
for ARindex = 1:length(ARs)
    LSTMUnits = ARs(ARindex);
    
    Averages = [];
    Bests = [];
    for SLindex = 1:length(SLs)
        sequenceLength = SLs(SLindex);
        
        suffix = "BestAR" + LSTMUnits + "SL" + sequenceLength + ".mat";
        
        disp(suffix)
        
        resultsFileName = resultsDir + suffix;
        netFileName = netDir + suffix;
        
        if(isfile(resultsFileName) == 0)
            [net, average, best] =...
                 trainMany(LSTMUnits, sequenceLength,...
                 standardizedData, yFeature);
            
            save(netFileName, 'net')
            save(resultsFileName, 'average', 'best')
        else
            load(resultsFileName)
        
        end
        
        Averages = [Averages; average];
        Bests = [Bests; best];
        
        subplot(1,2,1)
        hold on
        grid on
        
        plot(SLs(1:SLindex), Averages, "linewidth", 2)
        xlabel("Sequence Length")
        ylabel("RMSE (std)")
        title("Average")
        
        subplot(1,2,2)
        hold on
        grid on
        
        plot(SLs(1:SLindex), Bests, "linewidth", 2)
        xlabel("Sequence Length")
        ylabel("RMSE (std)")
        title("Best")
        
    end
    
    drawnow
    
end






















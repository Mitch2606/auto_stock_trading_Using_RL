
% for i = 1: 1
%     mdl = sim("StonkBotWithRewardModeling.slx");
%     
%     gains = a.finalWalletPrice(end) - 500;
%     
%     fprintf("\nROI: %2.5f", gains)
%     
%     if(gains >= 0)
%         continue
%     else
% %         [Tony, Paul] = makeBotsForRewardModeling();
% %         fprintf(" | New Bois!")
%     end
%     
%     
% end

[Tony, Paul] = makeBotsForRewardModeling();

env = rlSimulinkEnv("StonkBotWithRewardModeling",["StonkBotWithRewardModeling/Tony" "StonkBotWithRewardModeling/Paul"]);

trainOpts = rlTrainingOptions;

trainOpts.MaxEpisodes = 1000;
trainOpts.MaxStepsPerEpisode = 500;
trainOpts.StopTrainingCriteria = "EpisodeCount";
trainOpts.StopTrainingValue = 500;
trainOpts.ScoreAveragingWindowLength = 5;
trainOpts.Plots = "training-progress";

trainingInfo = train([Tony Paul],env,trainOpts);




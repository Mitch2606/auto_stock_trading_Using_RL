
function [Tony, Paul] = makeBotsForRewardModeling()
ObservationInfo = rlNumericSpec([1 8]);
ObservationInfo.Name = 'Stock History';

ActionInfo = rlFiniteSetSpec([1 2]);
ActionInfo.Name = 'Buy or Sell';

Tony = rlPPOAgent(ObservationInfo, ActionInfo);

ObservationInfo = rlNumericSpec([1 3]);
ObservationInfo.Name = 'Pertainent Stuff';

ActionInfo = rlFiniteSetSpec([-5:5]);
ActionInfo.Name = 'Reward';

Paul = rlPPOAgent(ObservationInfo, ActionInfo);

end
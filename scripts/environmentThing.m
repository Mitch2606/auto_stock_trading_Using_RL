ObservationInfo = rlNumericSpec([1 6]);
ObservationInfo.Name = 'Stock Parameters';
ObservationInfo.Description = 'choice, time, currentPrice, numShares, wallet, boughtPrice';

ActionInfo = rlFiniteSetSpec([1 2 3]);
ActionInfo.Name = 'Buy or Sell';

env = rlFunctionEnv(ObservationInfo,ActionInfo,'moneyBasedReward','myResetFunction');






load("bois.mat")

AMZN = standardizeData(AMZN);
CSCO = standardizeData(CSCO);
FB = standardizeData(FB);
MSFT = standardizeData(MSFT);
SBUX = standardizeData(SBUX);
TSLA = standardizeData(TSLA);

standardizedData = [{AMZN}, {CSCO}, {FB}, {MSFT}, {SBUX}, {TSLA}];

displayData(standardizedData)





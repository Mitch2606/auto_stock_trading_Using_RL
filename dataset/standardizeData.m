function standardizedData = standardizeData(inputData)

standardizedData = inputData;
for i = 1: size(inputData, 2)
   if(i == 2)
       continue;
   end
    
    [standardizedData(:, i), meanOfF, stdOfF] = normalize(inputData(:, i)); 
    
end

standardizedData(:,2) = [];

standardizedData = flip(standardizedData);

end





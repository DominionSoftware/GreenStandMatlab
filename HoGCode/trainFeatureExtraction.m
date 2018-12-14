clear;
close all;
resultsPathHOG = 'C:\Users\rickf\Google Drive\Greenstand\SVM\TestingResultsHOG';
resultsPathLBP = 'C:\Users\rickf\Google Drive\Greenstand\SVM\TestingResultsLBP';

trainingInputPath = 'C:\Users\rickf\Google Drive\Greenstand\SVM\TrainingSeg';
dataPath = 'C:\Users\rickf\Google Drive\Greenstand\SVM\Testing';

trainingSizes = getImageSizes(trainingInputPath,true);
dataSizes = getImageSizes(dataPath,true);
allSizes = [trainingSizes;dataSizes];

sortedSizes = sortrows(allSizes);
minRows = sortedSizes(end,1);
minCols = sortedSizes(end,2);

[trainingFeaturesHOG,trainingFeaturesLBP,trainingLabelsHOG,trainingLabelsLBP,extractionPathsHOG,extractionPathsLBP] = extractFeaturesFromData(trainingInputPath,true,minRows,minCols,false,true);
     
save('trainingData.mat','trainingFeaturesHOG','trainingFeaturesLBP','trainingLabelsHOG','trainingLabelsLBP','extractionPathsHOG','extractionPathsLBP','-v7.3');

dataPath = 'C:\Users\rickf\Google Drive\Greenstand\SVM\Testing';
 
[featuresHOG,featuresLBP,labelsHOG,labelsLBP,extractionPathsHOG,extractionPathsLBP] = extractFeaturesFromData(dataPath,true,minRows,minCols,false,true);
save('testingData.mat','featuresHOG','featuresLBP','extractionPathsHOG','extractionPathsLBP','labelsHOG','labelsLBP','-v7.3');


classifierHOG = fitcecoc(trainingFeaturesHOG, trainingLabelsHOG);

classifierLBP = fitcecoc(trainingFeaturesLBP, trainingLabelsLBP);
 
classifyAndCopyToFolders(resultsPathHOG,extractionPathsHOG,classifierHOG,featuresHOG);
classifyAndCopyToFolders(resultsPathLBP,extractionPathsLBP,classifierLBP,featuresLBP);
 


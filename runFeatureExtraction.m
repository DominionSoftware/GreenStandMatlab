clear;
close all;

% trainingInputPath = 'C:\Users\rickf\Google Drive\Greenstand\SVM\TrainingSeg';
% 
% [trainingFeaturesHOG,trainingFeaturesLBP,trainingLabels,trainingPaths] = extractFeaturesFromData(trainingInputPath,true,false,true);
%     
% save('trainingData.mat','trainingFeaturesHOG','trainingFeaturesLBP','trainingLabels','-v7.3');

dataPath = 'C:\Users\rickf\Google Drive\Greenstand\ImageData';
 
[featuresHOG,featuresLBP,labelsHOG,labelsLBP,extractionPathsHOG,extractionPathsLBP] = extractFeaturesFromData(dataPath,false,false,true);
save('data.mat','featuresHOG','featuresLBP','extractionPathsHOG','extractionPathsLBP','labelsHOG','labelsLBP','-v7.3');


classifierHOG = fitcecoc(trainingFeaturesHOG, trainingLabels);

classifierLBP = fitcecoc(trainingFeaturesLBP, trainingLabels);
 

predictedLabelsHOG = predict(classifierHOG, featuresHOG);
predictedLabelsLBP = predict(classifierLBP, featuresLBP);
[rows,cols] = size(predictedLabelsHOG);

for r = 1:rows
    outPath = strcat(resultsPath,char(predictedLabelsHOG(r,1)));
    
    sourcePath = extractionPathsHOG{1,r};
    %copyfile(sourcePath,outPath);
end


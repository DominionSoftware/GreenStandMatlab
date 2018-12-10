

close all;
clear all;
 
resultsPath = 'C:\Users\rickf\Google Drive\Greenstand\SVM\FinalResults\';

load('trainingData.mat');

classifierHOG = fitcecoc(trainingFeaturesHOG, trainingLabels);


load('extractedFeaturesData.mat');

predictedLabelsHOG = predict(classifierHOG, extractedFeatures);
[rows,cols] = size(predictedLabelsHOG);
for r = 1:rows
    outPath = strcat(resultsPath,char(predictedLabelsHOG(r,1)));
    
    sourcePath = extractionPaths{1,r};
    copyfile(sourcePath,outPath);
end

 
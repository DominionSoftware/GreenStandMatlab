

close all;
clear all;
 
resultsPath = 'D:\Projects\GreenStand\ImageData\FinalResults\';

load('trainingData.mat');

classifier = fitcecoc(trainingFeatures, trainingLabels);


load('extractedFeaturesData.mat');

predictedLabels = predict(classifier, extractedFeatures);
[rows,cols] = size(predictedLabels);
for r = 1:rows
    outPath = strcat(resultsPath,char(predictedLabels(r,1)));
    
    sourcePath = extractionPaths{1,r};
    copyfile(sourcePath,outPath);
end

 
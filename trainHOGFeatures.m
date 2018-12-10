close all;
clear all;

% Set the training image folder, the data should have folders with names
% the same as the labels....
trainingFolder = 'C:\Users\rickf\Google Drive\Greenstand\SVM\TrainingSeg';

trainingSet = imageDatastore(trainingFolder,'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% take a look at how many.
countEachLabel(trainingSet)

% read one in to test the cell size.

img = readAndScaleAndCropImage(trainingSet, 29,false);
seg = imsharpen(img);

[gm,ga] = imgradient(rgb2gray(seg),'roberts');
[hog_NxN, vishNxN] = extractHOGFeatures(img,'CellSize',[8,8]);
featuresLBP = extractLBPFeatures(rgb2gray(seg));
figure;
 
imshow(ga);
hold on;
% Visualize the HOG features

plot(vishNxN);
% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.

cellSize = [8 8];
hogFeatureSize = length(hog_NxN);
featuresLBPSize = length(featuresLBP);
numImages = numel(trainingSet.Files);
trainingFeaturesHOG = zeros(numImages, hogFeatureSize, 'single');
trainingFeaturesLBP = zeros(numImages, featuresLBPSize, 'single');


skippedTraining = [];

for i = 1:numImages
    try
        path = trainingSet.Files{i,1};
        
        srcimg = readAndScaleAndCropImage(trainingSet, i,false);
        img = imsharpen(srcimg);
        grayImage = rgb2gray(img);
        [gm,ga] = imgradient(grayImage,'roberts');
        [hf , vishNxN] = extractHOGFeatures(ga,'CellSize', cellSize);
        featuresLBP = extractLBPFeatures(grayImage);
        % some images do not produce the required number of features.
        % current approach is to skip.
        if length(hf) ~= hogFeatureSize
            skippedTraining = [skippedTraining,i];
            continue;
        end
        trainingFeaturesHOG(i, :) = hf;
        trainingFeaturesLBP(i,:) = featuresLBP;
    catch ME
        disp(ME);
    end
    
end

% remove the skipped images.
[rows,cols] = size(skippedTraining);
trainingFeaturesHOG(skippedTraining',:) = [];
trainingFeaturesLBP(skippedTraining',:) = [];
% Get labels for each image.
trainingLabels = trainingSet.Labels;
trainingLabels(skippedTraining',:) = [];

% save for next steps.
save('trainingData.mat','trainingFeaturesHOG','trainingFeaturesLBP','trainingLabels','-v7.3');









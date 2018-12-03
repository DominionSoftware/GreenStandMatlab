close all;
clear all;

trainingFolder = 'D:\Projects\GreenStand\ImageData\Training';

trainingSet = imageDatastore(trainingFolder,'IncludeSubfolders', true, 'LabelSource', 'foldernames');


countEachLabel(trainingSet)

img = readimage(trainingSet, 10);
img = rgb2gray(img);
[hog_NxN, vishNxN] = extractHOGFeatures(img,'CellSize',[16 , 16]);

figure;
subplot(2,3,1:3);
imshow(img);

% Visualize the HOG features
subplot(2,3,4);
plot(vishNxN);
% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.
cellSize = [16 16];
hogFeatureSize = length(hog_NxN);
numImages = numel(trainingSet.Files);
trainingFeatures = zeros(numImages, hogFeatureSize, 'single');
skippedTraining = [];

for i = 1:numImages
    try
        path = trainingSet.Files{i,1};
        
        srcimg = readimage(trainingSet, i);
        
        img = rgb2gray(srcimg);
        
        % Apply pre-processing steps
        %  img = imbinarize(img);
        [hf , vishNxN] = extractHOGFeatures(img,'CellSize', cellSize);
        
        subplot(2,3,1:3);
        imshow(img);
        
        % Visualize the HOG features
        subplot(2,3,4);
        plot(vishNxN);
        
        if length(hf) ~= hogFeatureSize
            skippedTraining = [skippedTraining,i];
            continue;
        end
        trainingFeatures(i, :) = hf;
    catch ME
        disp(ME);
    end
    
end

[rows,cols] = size(skippedTraining);
trainingFeatures(skippedTraining',:) = [];

% Get labels for each image.
trainingLabels = trainingSet.Labels;
trainingLabels(skippedTraining',:) = [];
save('trainingData.mat','trainingFeatures','trainingLabels');









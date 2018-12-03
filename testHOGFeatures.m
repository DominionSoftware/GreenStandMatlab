close all;
clear all;

trainingFolder = 'D:\Projects\GreenStand\ImageData\Training';
testingFolder  = 'D:\Projects\GreenStand\ImageData\Testing';


trainingSet = imageDatastore(trainingFolder,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');

testingSet     = imageDatastore(testingFolder, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

countEachLabel(trainingSet)

countEachLabel(testingSet)

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


% Get labels for each image.
trainingLabels = trainingSet.Labels;

classifier = fitcecoc(trainingFeatures, trainingLabels);


% Extract HOG features from the test set. The procedure is similar to what
% was shown earlier and is encapsulated as a helper function for brevity.

% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.

numImages = numel(testingSet.Files);
testingFeatures = zeros(numImages, hogFeatureSize, 'single');
skippedTesting = [];
for i = 1:numImages
    img = readimage(testingSet, i);
    
    img = rgb2gray(img);
    [hf , vishNxN] = extractHOGFeatures(img,'CellSize', cellSize);
     
    subplot(2,3,1:3); 
    imshow(img);

    % Visualize the HOG features
    subplot(2,3,4);  
    plot(vishNxN); 

    if length(hf) ~= hogFeatureSize
        skippedTesting = [skippedTesting,i];
        continue;
    end
    testingFeatures(i, :) = hf;
end
testLabels = testingSet.Labels;
 
% Make class predictions using the test features.
predictedLabels = predict(classifier, testFeatures);

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

 





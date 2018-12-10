
% script to get the HoG features from real-word data for classification.

close all;
clear all;

% point to folder.
extractionFolder  = 'C:\Users\rickf\Google Drive\Greenstand\ImageData';
extractionSet     = imageDatastore(extractionFolder, 'IncludeSubfolders', false);
displayImages = true;
wb = waitbar(0);

img = readAndScaleAndCropImage(extractionSet, 20);
img = imsharpen(img);
[gm,ga] = imgradient(rgb2gray(seg),'roberts');
[hog_NxN, vishNxN] = extractHOGFeatures(ga,'CellSize',[8 , 8]);
if (displayImages)
    figure;
    subplot(2,3,1:3);
    imshow(img);
    
    % Visualize the HOG features
    subplot(2,3,4);
    plot(vishNxN);
end

cellSize = [8 8];
hogFeatureSize = length(hog_NxN);
numImages = numel(extractionSet.Files);
extractedFeatures = zeros(numImages, hogFeatureSize, 'single');
skippedExtraction = [];
extractionPaths = {};
skippedPaths = {};

for i = 1:numImages
    try
        path = extractionSet.Files{i,1};
        
        img = readAndScaleAndCropImage(extractionSet, i);
        img = imsharpen(img);
        [hf , vishNxN] = extractHOGFeatures(img,'CellSize', cellSize);
        if (displayImages)
            subplot(2,3,1:3);
            imshow(img);
            subplot(2,3,4);
            plot(vishNxN);
        end
        if length(hf) ~= hogFeatureSize
            skippedExtraction = [skippedExtraction,i];
            skippedPaths = [skippedPaths,path];
            continue;
        end
        extractedFeatures(i, :) = hf;
        extractionPaths = [extractionPaths,path];
        wb = waitbar(i/numImages);
    catch ME
        disp(ME);
    end
    
end

extractedFeatures(skippedExtraction',:) = [];


save('extractedFeaturesData.mat','extractedFeatures','extractionPaths','-v7.3');





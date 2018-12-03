close all;
clear all;
extractionFolder  = 'D:\Projects\GreenStand\ImageData\ColorSegmented';
extractionSet     = imageDatastore(extractionFolder, 'IncludeSubfolders', false);
displayImages = false;


img = readimage(extractionSet, 2);
img = rgb2gray(img);
[hog_NxN, vishNxN] = extractHOGFeatures(img,'CellSize',[16 , 16]);
if (displayImages)
    figure;
    subplot(2,3,1:3);
    imshow(img);
    
    % Visualize the HOG features
    subplot(2,3,4);
    plot(vishNxN);
end

cellSize = [16 16];
hogFeatureSize = length(hog_NxN);
numImages = numel(extractionSet.Files);
extractedFeatures = zeros(numImages, hogFeatureSize, 'single');
skippedExtraction = [];
extractionPaths = {};
skippedPaths = {};

for i = 1:numImages
    try
        path = extractionSet.Files{i,1};
        
        srcimg = readimage(extractionSet, i);
        
        img = rgb2gray(srcimg);
        
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
    catch ME
        disp(ME);
    end
    
end

extractedFeatures(skippedExtraction',:) = [];


save('extractedFeaturesData.mat','extractedFeatures','extractionPaths');





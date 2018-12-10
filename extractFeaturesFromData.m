function [featuresHOG,featuresLBP,labelsHOG,labelsLBP,extractionPathsHOG,extractionPathsLBP] = extractFeaturesFromData(inputPath,includeSubFolders,minRows,minCols,showImages,showWaitBar)
% Set the training image folder, the data should have folders with names
% the same as the labels....
inputFolder = inputPath;
extractionPathsHOG = {};
extractionPathsLBP = {};

wb = [];
if showWaitBar
    wb = waitbar(0);
end

dataSet = imageDatastore(inputFolder,'IncludeSubfolders', includeSubFolders, 'LabelSource', 'foldernames');

% take a look at how many.
countEachLabel(dataSet)

numImages = numel(dataSet.Files);


if numImages > 20000
    nImages = floor(numImages / 3);
    disp(['selecting ',nImages,' images']);
    whichImages = datasample(1:numImages,nImages);
else
    whichImages = 1:numImages;
end

[~,numWhichImages] = size(whichImages);
 


img = readAndScaleAndCropImage(dataSet,10,minRows,minCols,false);

seg = imsharpen(img);
graySeg = rgb2gray(seg);
gpuGraySeg = gpuArray(graySeg);

[~,gpuGA] = imgradient(gpuGraySeg,'roberts');
ga = gather(gpuGA);

imshow(ga);
[hog_NxN, vishNxN] = extractHOGFeatures(ga,'CellSize',[8,8],'BlockSize',[4,4],'UseSignedOrientation',true);
featuresLBP = extractLBPFeatures(ga);

if (showImages)
    figure;
    imshow(ga);
    hold on;
    % Visualize the HOG features
    
    plot(vishNxN);
end
% Loop over the set and extract HOG features from each image.

cellSize = [8 8];
hogFeatureSize = length(hog_NxN);
featuresLBPSize = length(featuresLBP);

featuresHOG = zeros(numImages, hogFeatureSize, 'single');
featuresLBP = zeros(numImages, featuresLBPSize, 'single');


for w = 1:numWhichImages
    try
        i = whichImages(w);
        
        path = dataSet.Files{i,1};
        img = readAndScaleAndCropImage(dataSet, i,minRows,minCols,false);
        img = imsharpen(img);
        graySeg = rgb2gray(img);
        
        
        gpuGraySeg = gpuArray(graySeg);
        [~,gpuGA] = imgradient(gpuGraySeg,'roberts');
        ga = gather(gpuGA);
        [hf , ~] = extractHOGFeatures(ga,'CellSize', cellSize,'BlockSize',[4,4],'UseSignedOrientation',true);
        featuresLBP = extractLBPFeatures(ga);
      
        featuresHOG(i, :) = hf;
        
        
        featuresLBP(i,:) = featuresLBP;
        
        
        extractionPathsHOG = [extractionPathsHOG,path];
        
        
        extractionPathsLBP = [extractionPathsLBP,path];
        
        
        if showWaitBar
            waitbar(w/numWhichImages);
        end
    catch ME
        disp(ME);
    end
    
end



% Get labels for each image.
labelsHOG = dataSet.Labels;

labelsLBP = dataSet.Labels;


if showWaitBar
    close(wb);
end

end


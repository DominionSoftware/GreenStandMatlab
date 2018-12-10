function [sizes] = getImageSizes(path,includeSubFolders)
sizes = [];
dataSet = imageDatastore(path,'IncludeSubfolders', includeSubFolders, 'LabelSource', 'foldernames');
numImages = numel(dataSet.Files);
for i = 1:numImages
    path = dataSet.Files{i,1};
    img = imread(path);
    sizes = [sizes;size(img)];
end
end


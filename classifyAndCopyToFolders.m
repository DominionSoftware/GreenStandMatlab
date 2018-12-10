function [] = classifyAndCopyToFolders(resultsPath,extractionPaths,classifier,features)
%CLASSIFYANDCOPYTOFOLDERS classify and copy images to correct label folder.
 
predictedLabels = predict(classifier, features);

[rows,~] = size(predictedLabels);

for r = 1:rows
    outPath = strcat(resultsPath,'\',char(predictedLabels(r,1)));
    sourcePath = extractionPaths{1,r};
    copyfile(sourcePath,outPath);
end
end


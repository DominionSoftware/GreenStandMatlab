

minRows = 660;
minCols = 495;



img = imread('10614SEG.tif');
[rows,cols,~] = size(img);
padRows = 0;
padCols = 0;
if (rows ~= minRows)
    padRows = minRows - rows;
end
if cols ~= minCols
    padCols = minCols - cols;
end

if padRows ~= 0 || padCols ~= 0
    img = padarray(img,[round(padRows / 2),round(padCols/2)]);
end
seg = imsharpen(img);
graySeg = rgb2gray(seg);
gpuGraySeg = gpuArray(graySeg);

[~,gpuGA] = imgradient(gpuGraySeg,'roberts');
ga = gather(gpuGA);

gaSize = size(ga);
[hog_NxN, vishNxN] = extractHOGFeatures(ga,'CellSize',[8,8],'BlockSize',[4,4],'UseSignedOrientation',true);

img = imread('10097SEG.tif');
[rows,cols,~] = size(img);
padRows = 0;
padCols = 0;
if (rows ~= minRows)
    padRows = minRows - rows;
end
if cols ~= minCols
    padCols = minCols - cols;
end

if padRows ~= 0 || padCols ~= 0
    img = padarray(img,[round(padRows/2),round(padCols/2)]);
end
seg = imsharpen(img);
graySeg = rgb2gray(seg);
gpuGraySeg = gpuArray(graySeg);

[~,gpuGA] = imgradient(gpuGraySeg,'roberts');
ga = gather(gpuGA);

 gaSize1 = size(ga);
[hog_NxN1, vishNxN1] = extractHOGFeatures(ga,'CellSize',[8,8],'BlockSize',[4,4],'UseSignedOrientation',true);


disp(['gaSize = ',num2str(gaSize(1,1)),' ' ,num2str(gaSize(1,2))]);
disp(['gaSize1 = ',num2str(gaSize1(1,1)),' ', num2str(gaSize1(1,2))]);

disp(['hog_NxN = ',num2str(hog_NxN(1,1)), ' ' ,num2str(hog_NxN(1,2))]);


disp(['hog_NxN = ',num2str(hog_NxN(1,1)), ' ' ,num2str(hog_NxN(1,2))]);

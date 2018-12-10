function [output] = readAndScaleAndCropImage(dataSet, index, minRows,minCols, convert2Gray)

img = readimage(dataSet, index);
if convert2Gray
    img = rgb2gray(img);
end

[rows,cols,~] = size(img);
padRows = 0;
padCols = 0;
if (rows ~= minRows)
    padRows = minRows - rows;
end
if cols ~= minCols
    padCols = minCols - cols;
end

if padRows > 0
    img = padarray(img,[round(padRows/2),0]);
end
if padCols > 0
    img = padarray(img,[0,round(padCols/2)]);
end
if padRows < 0
    rws = round(abs(padRows)/2);
    img =  img(1+rws:end-rws,:);
end
if padCols < 0
    cms = round(abs(padCols)/2);
    img =  img(:,1+cms:end-cms);
end

output = img;
end


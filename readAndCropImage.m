function [output] = readAndCropImage(dataSet, index)
%READANDCROPIMAGE  Read the image from the dataset convert to gray, and
%crop in the middle 1/4 of the image

img = readimage(dataSet, index);
 
img = rgb2gray(img);
 
[rows,cols] = size(img);
r4 = int16(rows/8);
c4 = int16(cols/8);
r2 = r4 * 6;
c2 = c4 * 6;
output = img(r4:r4 + r2,c4:c4+c2);
   
 
end


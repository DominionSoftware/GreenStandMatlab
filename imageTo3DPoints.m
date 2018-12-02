function [sortedPoints] = imageTo3DPoints(I)
[rows,cols] = size(I);
pixels = zeros(rows * cols,3);

pr = 1;
for r = 1:rows
    pixels(pr:pr+cols-1,2) = r;
    pixels(pr:pr+cols-1,1) = I(r,1:cols)';
    pixels(pr:pr+cols-1,3) = (1:cols)';
    pr = pr + cols;
end


sortedPoints = sortrows(pixels,'descend');
end


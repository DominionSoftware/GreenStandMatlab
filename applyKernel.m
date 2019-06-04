function [outPixel] = applyKernel(image,kernel,pixCol,pixRow,width,normal)
rowOffset = floor(width / 2);
colOffset = floor(width / 2);
sum = 0.0;
computedPixRow = pixRow - rowOffset;

for kr = 1:width
    computedPixCol = pixCol - colOffset;
    for kc = 1:width
        pix = image(computedPixRow + 1,computedPixCol + 1);
        sum = sum + double(pix * kernel(kr,kc));
        computedPixCol = computedPixCol + 1;
    end
    computedPixRow = computedPixRow + 1;
end
outPixel = sum / normal;
end


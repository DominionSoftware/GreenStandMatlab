function [rgbImage] = SegmentGreenWithOtsu(image)
%SEGMENTGREENWITHOTSU apply Otsu's method to the a* channel in L*a*b*
%space, apply that threshold to the L* channel to segment the green channel
 labIm1 = rgb2lab(image);

channelA = labIm1(:,:,2);
 mn = min(min(channelA));
 
channelA = channelA + abs(mn);
channelA = channelA./ max(max(channelA));

[counts, ~] = imhist(channelA);
 
 cut = otsuthresh(counts);

mask =imbinarize(channelA,cut);
mask3 = cat(3, mask, mask, mask);
rgbImage = lab2rgb(labIm1);
rgbImage(mask3) = 0;
end


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
 channelL = labIm1(:,:,1);
  
channelL(channelA > cut) = 0;
labIm1(:,:,1) = channelL;
rgbImage = lab2rgb(labIm1);

end


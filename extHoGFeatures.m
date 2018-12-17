function [features,visible] = extHoGFeatures(img)
%EXTHOGFEATURES Wrapper to provide consistent parameters.
%   Detailed explanation goes here
 [features , visible] = extractHOGFeatures(img,'CellSize', [8,8],'NumBins',18,'UseSignedOrientation',true);
end


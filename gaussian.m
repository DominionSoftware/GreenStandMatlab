function [img,normalFactor] = gaussian(width,sigma)
img = zeros(width,width);
center = width / 2;
sigmaSquared = sigma * sigma;
for c = 1:width
    
    for r = 1:width
        
        distanceSquared = (c - center) * (c - center) + (r - center) * (r - center);
        numerator = exp( -distanceSquared / (2.0 * sigmaSquared));
        
        img(r,c) = numerator / (2.0 * pi * sigmaSquared);
    end
end



normalFactor = 0.0;
for c = 1:width
    
    for r = 1:width
        
        normalFactor = normalFactor + img(r,c);
    end
end




end


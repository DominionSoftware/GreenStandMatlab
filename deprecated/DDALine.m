function [I] = DDALine( xStart,yStart,xEnd,yEnd,image,pixelValue)
%Draw a line onto the image, if pixelValue <> NaN
pixelsUnderLine = [];
pixelColRows = [];
xStart = xStart;
yStart = yStart;
xEnd = xEnd;
yEnd = yEnd;

if (xEnd < xStart)
    temp = xStart;
    xStart = xEnd;
    xEnd = temp;
    temp = yStart;
    yStart = yEnd;
    yEnd = temp;
end

rndX = xStart;
rndY = yStart;
x = xStart
y = yStart
deltaX = xEnd - xStart;
deltaY = yEnd - yStart;
error = 0;
pixelColRows = [pixelColRows;[x,y]];
pixelsUnderLine = [pixelsUnderLine  image(x,y)];
image(x,y) = pixelValue;

if (abs(deltaY) <= deltaX)
    if (deltaY >= 0)
        c1 = deltaX - 2 * deltaY;
        c2 = 2 * deltaY;
        c3 = 2 * (deltaY - deltaX);
        while (x < xEnd)
            x = x + 1;
            if (error < c1)
                error = error + c2;
            else
                rndY = rndY+1;
                error = error + c3;
            end
            pixelColRows = [pixelColRows;[x,y]];
            pixelsUnderLine = [pixelsUnderLine  image(x,rndY)];
            if ~isnan(pixelValue)
                image(x,rndY) = pixelValue;
            end
        end
    else
        c1 = -(deltaX + 2 * deltaY);
        c2 = 2 * deltaY;
        c3 = 2 * (deltaY + deltaX);
        while(x < xEnd)
            x = x + 1;
            if (error >= c1)
                error = error + c2;
            else
                rndY = rndY - 1;
                error = error + c3;
            end
            pixelColRows = [pixelColRows;[x,y]];
            pixelsUnderLine = [pixelsUnderLine  image(x,rndY)];
         	if ~isnan(pixelValue)
                image(x,rndY) = pixelValue;
            end
            
        end
    end
else
    if (deltaY >= 0)
        c1 = deltaY - 2 * deltaX;
        c2 = 2 * deltaX;
        c3 = 2 * (deltaX -deltaY);
        while(y < yEnd)
            y = y + 1;
            if (error < c1)
                error = error + c2;
            else
                rndX = rndX + 1;
                error = error + c3;
            end
            pixelColRows = [pixelColRows;[x,y]];
            pixelsUnderLine = [pixelsUnderLine  image(rndX,y)];
            if ~isnan(pixelValue)
                image(rndX,y) = pixelValue;
            end
            
        end
    else
        c1 = deltaY + 2 * deltaX;
        c2 = -2 * deltaX;
        c3 = -2 * (deltaX + deltaY);
        while (y > yEnd)
            y = y - 1;
            if (error > c1)
                error = error + c2;
            else
                rndX = rndX + 1;
                error = error + c3;
            end
            pixelColRows = [pixelColRows;[x,y]];
            pixelsUnderLine = [pixelsUnderLine  image(rndX,y)];
            if ~isnan(pixelValue)
                image(rndX,y) = pixelValue;
            end
        end
    end
end


I = image;

end



cX = 300/2;
cY = 300/2;
xStart = 300/2;
yStart = 25;
xEnd = cX;
yEnd = cY;
cXRange = cX-2:cX+2;
pixelValue = 120;
range = 0:5:90;

 
templateImage0 = makeTemplate(300,300,xStart,yStart,xEnd,yEnd,pixelValue,range,cXRange);



pixelValue = 166;
range = 0:10:90;
 
center = cX;
templateImage = makeTemplate(300,300,xStart,yStart,xEnd,yEnd,pixelValue,range,cXRange);

pixelValue = 190;
yStart = 75;
range = 10:15:90;
templateImage3 = makeTemplate(300,300,xStart,yStart,xEnd,yEnd,pixelValue,range,cXRange);

pixelValue = 200;
yStart = 100;
range = 5:15:90;
templateImage2 = makeTemplate(300,300,xStart,yStart,xEnd,yEnd,pixelValue,range,cXRange);


pixelValue = 255;
yStart = 125;
range = 10:20:90;
templateImage4 = makeTemplate(300,300,xStart,yStart,xEnd,yEnd,pixelValue,range,cXRange);


templateImage = templateImage0 + templateImage + templateImage2 + templateImage3 + templateImage4;
templateFlipUD = flipud(templateImage);

templateImage = templateImage + templateFlipUD;

templateFlipLR = fliplr(templateImage);
templateImage = templateImage + templateFlipLR;
 
h = fspecial('gaussian',5,0.6);
templateImage = imfilter(templateImage,h);
imtool(templateImage);
imwrite(templateImage,'templateC.tif');



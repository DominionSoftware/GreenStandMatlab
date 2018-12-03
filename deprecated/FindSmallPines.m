clear all;
 close all;

segmented = 'D:\Projects\GreenStand\ImageData\ColorSegmented';
pine = 'D:\Projects\GreenStand\ImageData\Pinus_pendula';
 
 
ds = datastore({segmented},'Type','image','FileExtensions',{'.jpg','.tif','.png'});
output = [];
[dsRows,dsCols] = size(ds.Files);
 
resultImage=  zeros(1000,1000);

 desiredCentroid = [355,455];
 
for i = 1:dsRows
    try
   
        
        filePath = ds.Files(i);
        [filepath,name,ext] = fileparts(filePath{1,1});
        if ~contains(name,'TEMPLATEMATCH')
            continue;
        end
        newStr = erase(name,'TEMPLATEMATCH');
        segPath = fullfile(filepath,strcat(newStr,'SEG.tif'));
        displayImage = imread(segPath);
       
        imshow(displayImage);
        
         data = readimage(ds,i);
         imshow(data);
         pixelsSorted = imageTo3DPoints(data);
       
        v = [pixelsSorted(1,2),pixelsSorted(1,3)];
       
        d = norm(v-desiredCentroid);
        if (d < 75)
            resultImage(pixelsSorted(1,2),pixelsSorted(1,3)) = resultImage(pixelsSorted(1,2),pixelsSorted(1,3)) + pixelsSorted(1,1);
            newStr = erase(name,'TEMPLATEMATCH');
            segPath = fullfile(filepath,strcat(newStr,'SEG.tif'));
            movefile(segPath,pine);
            movefile(filePath{1,1},pine);
        end
       
      
    catch ME
        continue;
    end

end
imtool(resultImage);
fitswrite(resultImage,'result.fits');    








clear all;
 close all;

segmented = 'D:\Projects\GreenStand\ImageData\ColorSegmented';
pine = 'D:\Projects\GreenStand\ImageData\Pinus_Pendula';
 
 
ds = datastore({segmented},'Type','image','FileExtensions',{'.jpg','.tif','.png'});
output = [];
[dsRows,dsCols] = size(ds.Files);
 
resultImage=  zeros(1000,1000);

 
 
for i = 1:dsRows
    try
   
        filePath = ds.Files(i);
        [filepath,name,ext] = fileparts(filePath{1,1});
        if ~contains(name,'TEMPLATEMATCH')
            continue;
        end
       
        data = readimage(ds,i);
        [rows,cols] = size(data);
        pixels = zeros(rows * cols,3);
        
        pr = 1;
       for r = 1:rows
            pixels(pr:pr+cols-1,2) = r;
            pixels(pr:pr+cols-1,1) = data(r,1:cols)';
            pixels(pr:pr+cols-1,3) = (1:cols)';
            pr = pr + cols;
        end
        
        
        pixelsSorted = sortrows(pixels,'descend');
        resultImage(pixelsSorted(1,2),pixelsSorted(1,3)) = resultImage(pixelsSorted(1,2),pixelsSorted(1,3)) + pixelsSorted(1,1);
       
      
    catch ME
        continue;
    end

end
imtool(resultImage);
    






clear all;

location1 = 'D:\Projects\GreenStand\ImageData';
thumbnails = 'D:\Projects\GreenStand\ImageData\Thumbnails';

segmented = 'D:\Projects\GreenStand\ImageData\ColorSegmented';
pine = 'D:\Projects\GreenStand\ImageData\Pinus_Pendula';
templateNeedles = imread('templateF.tif');
 
ds = datastore({location1},'Type','image','FileExtensions',{'.jpg','.tif','.png'});
output = [];
[dsRows,dsCols] = size(ds.Files);
wb = waitbar(0);

gpuTemplateNeedles = gpuArray(templateNeedles);
 
for i = 1:dsRows
    try
        waitbar(i/dsRows);
        filePath = ds.Files(i);
        
        data = readimage(ds,i);
        [BW,SC] = createMask1(data);
        
        [filepath,name,ext] = fileparts(filePath{1,1});
        f = fullfile(segmented,strcat(name,'SEG','.tif'));
        imwrite(SC,f);
        
        % try to find pinus_pendula
        imageGray = rgb2gray(SC);
        gpuImageGray = gpuArray(imageGray);
        gpuMatch = normxcorr2(gpuTemplateNeedles,gpuImageGray);
        match = gather(gpuMatch);
       
        f = fullfile(segmented,strcat(name,'TEMPLATEMATCH','.tif'));
  
        imwrite(match,f);
       
      
    catch ME
        continue;
    end
    
end
close(wb);







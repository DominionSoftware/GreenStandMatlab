clear all;
close all;


location = 'C:\Users\rickf\Google Drive\Greenstand\SVM\Training';


segmented = 'C:\Users\rickf\Google Drive\Greenstand\SVM\TrainingSeg';
  
ds = imageDataStore({location1},'FileExtensions',{'.jpg','.tif','.png'},);
 
[dsRows,dsCols] = size(ds.Files);
wb = waitbar(0);
filePath = ds.Files(1);
        
data = readAndScaleAndCropImage(ds,1,true);

 
for i = 3:dsRows
    try
 
        filePath = ds.Files(i);
        
        data = readAndScaleAndCropImage(ds,i,false);
        [mask,seg] = createMask1(data);
        
        seg = imsharpen(seg);
        [gm,ga] = imgradient(rgb2gray(seg),'roberts');
        
      [featureVector,hogVisualization] = extractHOGFeatures(ga,'UseSignedOrientation',1);
        figure;
        ga = ga - min(min(ga));
        ga = ga./max(max(ga));
        imshow(ga); 
        hold on;
        plot(hogVisualization,'Color','r');
        [filepath,name,ext] = fileparts(filePath{1,1});
        f = fullfile(segmented,strcat(name,'SEG','.tif'));
        %imwrite(seg,f);
        waitbar(i/dsRows);
    catch ME
        continue;
    end
    
end
close(wb);







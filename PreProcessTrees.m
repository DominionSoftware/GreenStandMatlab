clear all;

location1 = 'D:\Projects\GreenStand\ImageData\Images11.5.18';
thumbnails = 'D:\Projects\GreenStand\ImageData\Thumbnails';
defective = 'C:\Users\rickf\Google Drive\Greenstand\Defective';

ds = datastore({location1},'Type','image','FileExtensions',{'.jpg','.tif','.png'});
 
[dsRows,dsCols] = size(ds.Files);
 
for i = 1:dsRows
    try
    waitbar(i/dsRows);
    filePath = ds.Files(i);
    k = strfind(filePath,'thumb');
    if ~isempty(k{1})
        movefile(filePath{1,1},thumbnails);
        continue;
    end
    data = readimage(ds,i);   
    grayImage = rgb2gray(data);
    grayImage = single(grayImage);
   
    
    [~,~,~,~,meas] = brenners(grayImage);
    if (meas < 200)
        movefile(filePath{1,1},defective);
    end
    catch ME
        continue;
    end
end


  
                  
                  
                  
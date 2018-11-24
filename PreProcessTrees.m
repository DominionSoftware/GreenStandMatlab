clear all;

location1 = 'D:\Projects\GreenStand\ImageData';
thumbnails = 'D:\Projects\GreenStand\ImageData\Thumbnails';
defective = 'D:\Projects\GreenStand\ImageData\Defective';

measureTypes = {
'ACMO', 'Absolute central moment (Shirvaikar2004)';
'BREN', 'Brenners focus measure (Santos97)';
'CONT', 'Image contrast (Nanda2001)';
'CURV', 'Image curvature (Helmli2001)';
'DCTE', 'DCT Energy measure (Shen2006)';
'DCTR', 'DCT Energy ratio (Lee2009)';
'GDER', 'Gaussian derivative (Geusebroek2000)';
'GLVA', 'Gray-level variance (Krotkov86)';
'GLLV', 'Gray-level local variance (Pech2000)';
'GLVN', 'Gray-level variance normalized (Santos97)';
'GRAE', 'Energy of gradient (Subbarao92)';
'GRAT', 'Thresholded gradient (Santos97)';
'GRAS', 'Squared gradient (Eskicioglu95)';
'HELM', 'Helmlis measure (Helmli2001)';
'HISE', 'Histogram entropy (Krotkov86)';
'HISR', 'Histogram range (Firestone91)';
'LAPE', 'Energy of Laplacian (Subbarao92)';
'LAPM', 'Modified laplacian (Nayar89)';
'LAPV', 'Variance of laplacian (Pech2000)';
'LAPD', 'Diagonal Laplacian (Thelen2009)';
'SFIL', 'Steerable filters-based (Minhas2009)';
'SFRQ', 'Spatial frequency (Eskicioglu95)';
'TENG', 'Tenegrad (Krotkov86)';
'TENV', 'Tenengrad variance (Pech2000)';
'VOLA', 'Vollats correlation-based (Santos97)';
%'WAVS', 'Wavelet sum (Yang2003)';
%'WAVV', 'Wavelet variance (Yang2003)';
%'WAVR', 'Wavelet ratio (Xie2006)';
};

 [rows,cols] = size(measureTypes);
ds = datastore({location1},'Type','image','FileExtensions',{'.jpg','.tif','.png'});
output = [];
[dsRows,dsCols] = size(ds.Files);
varNames = {'Path','Measure','MeasureType','MeasureTypeDescription'};
varTypes = {'string','double','string','string'};
T = table('Size',[dsRows * rows,4],'VariableTypes',varTypes,'VariableNames',varNames);
allRows = 1;
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
    T(allRows,:) =  {filePath,meas,'BREN','Brenners focus measure (Santos97)'};
    allRows = allRows + 1;
    end

T(ismissing(T.Path),:) = [];
writetable(T,'Contrast Results.csv');


  
                  
                  
                  
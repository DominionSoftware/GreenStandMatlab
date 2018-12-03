
close all;
clear all;

image = fitsread('result.fits');
image = image(1:800,1:600);

 image(image > 180000) = 0;
 image(image <= 300) = 0;
 image(image > 300) = 300;
points = imageTo3DPoints(image);
points(points(:,1) < 1,:) = [];
 points = [points(:,2),points(:,3),points(:,1)];
 
eva = evalclusters(points,'kmeans','DaviesBouldin','KList',[1:5])
opts = statset('Display','final');
[idx,C] = kmeans(points,eva.OptimalK,'Replicates',3,'Options',opts);
for k = 1:eva.OptimalK
    pts = points(idx == k,:);
    ptCloud = pointCloud(pts);
    pcshow(ptCloud);
      hold on;
    plot3(C(k,1),C(k,2),C(k,3),'*');
   
end




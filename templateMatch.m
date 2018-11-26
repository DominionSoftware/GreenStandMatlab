function [values,result] = templateMatch(image,template)
 [trows,tcols] = size(template);
 [irows,icols] = size(image);
 imageSource = zeros(irows+trows,icols+tcols);
 imageSource(1:irows,1:icols) = image(:,:);
 [isrows,iscols] = size(imageSource);
 
 result = ones(isrows,iscols);
 
 for ir = 1:isrows - trows
     for ic = 1:iscols-tcols
         result(ir,ic) = corr2(imageSource(ir:ir+trows-1,ic:ic+tcols-1),template);
     end
     
 end
result = result(1:irows,1:icols);
values = zeros(irows * icols,3);
vr = 1;
for ir = 1:irows
    for ic = 1:icols
        values(vr,1) = result(ir,ic);
        values(vr,2) = ir;
        values(vr,3) = ic;
    end
end

values = sortrows(values);


end


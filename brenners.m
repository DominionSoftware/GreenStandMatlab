function [DH,DV,Mx,M2,Measure] = brenners(Image)
        [M, N] = size(Image);
        DH = zeros(M, N,'single');
        DV = zeros(M, N,'single');
        DHG = gpuArray(DH);
        DVG = gpuArray(DV);
        IG = gpuArray(Image);
        DVG(1:M-2,:) = IG(3:end,:)-IG(1:end-2,:);
        DHG(:,1:N-2) = IG(:,3:end)-IG(:,1:end-2);
        Mx = max(abs(DHG), abs(DVG));        
        M2 = Mx.^2;
        M2CPU = gather(M2);
        
        Measure = mean2(M2CPU);
end


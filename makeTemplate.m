function [output] = makeTemplate(rows,cols,xStart,yStart,xEnd,yEnd,pixelValue,range,cXRange)
 
output = zeros(rows,cols,'uint8');
 for center = cXRange
    xEnd = center;
    yEnd = center;
    for theta=range
        M = RotZ((theta * pi) / 180);
        T = eye(3);
        T(1,3) = center;
        T(2,3) = center;
        Tminus = eye(3);
        Tminus(1,3) = -center;
        Tminus(2,3) = -center;
        Transform = T * M * Tminus;
        
        transformed = Transform * [xStart,yStart,1]';
        if transformed(1) < 1
            transformed(1) = 1;
        end
        if transformed(2) < 1
            transformed(2) = 1;
        end
        
         if transformed(1) > 300
            transformed(1) = 300;
        end
       if transformed(2) > 300
            transformed(2) = 300;
        end
        output = DDALine(round(transformed(1)),round(transformed(2)),xEnd,yEnd,output,pixelValue);
    end
 end
end


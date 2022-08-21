function [output] = getORBFeatures(I, NrPts, BlockSize)

    if(size(I,3)==3)
        I = rgb2gray(I);
    end

    points = detectORBFeatures(I);
    if(size(points,1)<NrPts)
        points = detectORBFeatures(I,'ScaleFactor',1.001);
        if(size(points,1)<NrPts)
            points = detectORBFeatures(histeq(I));
        end
    end
    if(size(points,1)==0)
        y1=0;
        y2=0;
        y3=0;
        y4=0;
        y5=0;
    else
        selected_points = points.selectStrongest(NrPts);
        selPts = selected_points.Location;
        [features, ~] = extractFeatures(I, selPts, 'Method', 'Block', 'BlockSize', BlockSize);
    
        y1 = mean(mean(features,2));
        y2 = mean(median(features,2));
        y3 = mean(std(features,0,2));
        tmp = skewness(features,1,2);
        tmp2= isnan(tmp);
        tmp(tmp2)=1000;
        y4  = mean(tmp);
        tmp = kurtosis(features,1,2);
        tmp2= isnan(tmp);
        tmp(tmp2)=1000;
        y5  = mean(tmp);
       
    end
    
    if(isnan(y1))
        y1=0;
    end
    if(isnan(y2))
        y2=0;
    end
    if(isnan(y3))
        y3=0;
    end
    if(isnan(y4))
        y4=0;
    end
    if(isnan(y5))
        y5=0;
    end
    
    output = [y1, y2, y3, y4, y5];

end



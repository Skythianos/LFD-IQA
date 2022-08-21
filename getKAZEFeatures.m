function [output] = getKAZEFeatures(I, NrPts, BlockSize)

    if(size(I,3)==3)
        I = rgb2gray(I);
    end
    
    points = detectKAZEFeatures(I);
    if(size(points,1)<NrPts)
        points = detectKAZEFeatures(I,'Threshold',0.000001);
        if(size(points,1)<NrPts)
            points = detectKAZEFeatures(histeq(I));
        end
    end
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




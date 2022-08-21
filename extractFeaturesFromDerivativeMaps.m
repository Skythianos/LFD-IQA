function [output] = extractFeaturesFromDerivativeMaps(RGB, NrPts, BlockSize)

    YCbCr = im2double(rgb2ycbcr(RGB));
    Y     = mat2gray(YCbCr(:,:,1), [16/255, 235/255]);
    Cb    = mat2gray(YCbCr(:,:,2), [16/255, 240/255]);
    Cr    = mat2gray(YCbCr(:,:,3), [16/255, 240/255]);
    [h] = getDerivativeFilters();
    
    DerivativeMaps_Y = cell(5,1);
    DerivativeMaps_Cb= cell(5,1);
    DerivativeMaps_Cr= cell(5,1);  
        
    for i=1:5
        minmax = getMinMax(h{i,1},1);
        DerivativeMaps_Y{i,1} = mat2gray(imfilter(Y, h{i,1}, 'conv'), [minmax(1), minmax(2)]);
        DerivativeMaps_Cb{i,1}= mat2gray(imfilter(Cb,h{i,1}, 'conv'), [minmax(1), minmax(2)]);
        DerivativeMaps_Cr{i,1}= mat2gray(imfilter(Cr,h{i,1}, 'conv'), [minmax(1), minmax(2)]);
    end
    
    DerivativeMaps = [DerivativeMaps_Y;DerivativeMaps_Cb;DerivativeMaps_Cr];
    
    tmp = [];
    for i=1:15
        feat = getLocalFeatures(DerivativeMaps{i,1}, NrPts, BlockSize);
        tmp = [tmp, feat]; 
    end
    output = tmp;

end


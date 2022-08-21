function [output] = extractFeaturesFromHighBoostMaps(RGB, NrPts, BlockSize)

    YCbCr = im2double(rgb2ycbcr(RGB));
    Y     = mat2gray(YCbCr(:,:,1), [16/255, 235/255]);
    Cb    = mat2gray(YCbCr(:,:,2), [16/255, 240/255]);
    Cr    = mat2gray(YCbCr(:,:,3), [16/255, 240/255]);
    [h] = getHighBoostFilter();
    
    HighBoostMaps_Y = cell(4,1);
    HighBoostMaps_Cb= cell(4,1);
    HighBoostMaps_Cr= cell(4,1);  
        
    for i=1:4
        H = h^i;
        minmax = getMinMax(H, 1);
        HighBoostMaps_Y{i,1} = mat2gray(imfilter(Y, H, 'conv'), [minmax(1), minmax(2)]);
        HighBoostMaps_Cb{i,1}= mat2gray(imfilter(Cb,H, 'conv'), [minmax(1), minmax(2)]);
        HighBoostMaps_Cr{i,1}= mat2gray(imfilter(Cr,H, 'conv'), [minmax(1), minmax(2)]);
    end
    
    HighBoostMaps = [HighBoostMaps_Y;HighBoostMaps_Cb;HighBoostMaps_Cr];
    
    tmp = [];
    for i=1:12
        feat = getLocalFeatures(HighBoostMaps{i,1}, NrPts, BlockSize);
        tmp = [tmp, feat]; 
    end
    output = tmp;

end


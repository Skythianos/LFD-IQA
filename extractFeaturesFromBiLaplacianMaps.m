function [output] = extractFeaturesFromBiLaplacianMaps(RGB, NrPts, BlockSize)

    YCbCr = im2double(rgb2ycbcr(RGB));
    Y     = mat2gray(YCbCr(:,:,1), [16/255, 235/255]);
    Cb    = mat2gray(YCbCr(:,:,2), [16/255, 240/255]);
    Cr    = mat2gray(YCbCr(:,:,3), [16/255, 240/255]);
    [BiLaplacianFilters] = getBiLaplacianFilters();
    
    BiLaplacianMaps_Y = cell(7,1);
    BiLaplacianMaps_Cb= cell(7,1);
    BiLaplacianMaps_Cr= cell(7,1);
    
    for i=1:7
        minmax = getMinMax(BiLaplacianFilters{1,1},1);
        BiLaplacianMaps_Y{i,1} = mat2gray(imfilter(Y, BiLaplacianFilters{i,1}, 'conv'), [minmax(1), minmax(2)]);
        BiLaplacianMaps_Cb{i,1}= mat2gray(imfilter(Cb,BiLaplacianFilters{i,1}, 'conv'), [minmax(1), minmax(2)]);
        BiLaplacianMaps_Cr{i,1}= mat2gray(imfilter(Cr,BiLaplacianFilters{i,1}, 'conv'), [minmax(1), minmax(2)]);
    end
    
    BiLaplacianMaps = [BiLaplacianMaps_Y;BiLaplacianMaps_Cb;BiLaplacianMaps_Cr];
    
    tmp = [];
    for i=1:21
        feat = getLocalFeatures(BiLaplacianMaps{i,1}, NrPts, BlockSize);
        tmp = [tmp, feat]; 
    end
    output = tmp;
       
end


function [output] = getLocalFeatures(map, NrPts, BlockSize)
    
    tmp1 = getBRISKFeatures(map, NrPts, BlockSize);
    tmp2 = getFASTFeatures(map, NrPts, BlockSize);
    tmp3 = getHarrisFeatures(map, NrPts, BlockSize);
    tmp4 = getKAZEFeatures(map, NrPts, BlockSize);
    tmp5 = getMinEigenFeatures(map, NrPts, BlockSize);
    tmp6 = getORBFeatures(map, NrPts, BlockSize);
    tmp7 = getSURFFeatures(map, NrPts, BlockSize);
    
    output = [tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7];

end


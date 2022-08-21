function [output] = extractImageFeatures(RGB, NrPts, BlockSize)

    output = [extractFeaturesFromBiLaplacianMaps(RGB, NrPts, BlockSize), ...
        extractFeaturesFromHighBoostMaps(RGB, NrPts, BlockSize),...
        extractFeaturesFromDerivativeMaps(RGB, NrPts, BlockSize)];

end


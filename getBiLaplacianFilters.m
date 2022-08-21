function [BiLaplacian] = getBiLaplacianFilters()

    L1 = [0 1 0;1 -4 1;0 1 0];
    L2 = [1 -2 1;-2 4 -2;1 -2 1];
    L3 = [1 0 1;0 -4 0;1 0 1];
    L4 = [-2 1 -2;1 4 1;-2 1 -2];
    L5 = [-1 -1 -1;-1 8 -1;-1 -1 -1];
    
    BiLaplacian = cell(7,1);

    BiLaplacian{1,1} = L1*L1;
    BiLaplacian{2,1} = L2*L2;
    BiLaplacian{3,1} = L3*L3;
    BiLaplacian{4,1} = L4*L4;
    BiLaplacian{5,1} = L5*L5;
    BiLaplacian{6,1} = L1*L3;
    BiLaplacian{7,1} = L2*L4;

end


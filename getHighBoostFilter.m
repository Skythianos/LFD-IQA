function [h] = getHighBoostFilter(C)

    if(nargin<1)
        C=1;
    end
    
    h=[-C -C -C;-C 8*C+1 -C;-C -C -C];

end


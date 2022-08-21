function [minmax] = getMinMax(L, d)

    minmax = zeros(1,2);
    for i=1:size(L,1)
        for j=1:size(L,2)
            if(L(i,j)>0)
                minmax(2) = minmax(2) + L(i,j)*d;
            else
                minmax(1) = minmax(1) + L(i,j)*d;
            end
        end
    end

end

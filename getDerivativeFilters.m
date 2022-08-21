function [filters] = getDerivativeFilters()

    sides = [3,5,7,9,11];
    filters = cell(size(sides,2), 1);
        
    for i=1:size(sides,2)
        filters{i,1} = getDerivativeFilter(sides(i))*(-getDerivativeFilter(sides(i)));
    end

end


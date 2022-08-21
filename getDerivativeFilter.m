function [filter] = getDerivativeFilter(side)

    filter = zeros(side,side);
    for i=1:side
        if(mod(i,2)==1)
            filter(i,:) = (-1).^(1:side);
        else
            filter(i,:) = (-1).^(0:side-1);
        end
    end

    filter(side/2+0.5, side/2+0.5)=0; 

end


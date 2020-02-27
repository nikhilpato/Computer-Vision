function O = normalizeRGB(I)
    
    O = zeros(size(I));
    
    for color=1:size(I,3)
        for row=1:size(I,1)
            for col=1:size(I,2)   
                O(row,col,color) = (255*I(row,col,color)) / ...
                    (I(row,col,1) + I(row,col,2) + I(row,col,3));
            end   
        end
    end
end


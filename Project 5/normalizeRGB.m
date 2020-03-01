function O = normalizeRGB(I)
    
    O = uint8(zeros(size(I)));
    
    for color=1:size(I,3)
        for row=1:size(I,1)
            for col=1:size(I,2)   
                R = double(I(row,col,1))/255;
                G = double(I(row,col,2))/255;
                B = double(I(row,col,3))/255;
                cur_channel = double(I(row,col,color))/255;
                O(row,col,color) = uint8(255*(cur_channel / (R+B+G)));
            end   
        end
    end
end


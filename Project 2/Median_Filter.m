function O = Median_Filter(I, filter_size)
%Median_Filter performs a order-statistic median filter
%   Does the same thing as imfilter()
    O = zeros(size(I));
    
    I = double(I);
    % Determine what row/col to start, use zero padding
    eff_size = floor(filter_size/2);
    % WHY DOES MATLAB HAVE TO INDEX AT 1?!?!?   AHHAHHAHAHAIWHBVYIRBVUYAYC
    for row = 1+eff_size:size(I,1)-eff_size
        for col = 1+eff_size:size(I,2)-eff_size
            img_seg = I(row-eff_size:row+eff_size,col-eff_size:col+eff_size);
            O_px = median(img_seg,'all');
            % saturate
            O(row,col)=sat(O_px, 0, 255);
        end
    end
end


function O = lin_img_conv(I,F)
%LIN_IMG_CONV Does the same thing as imfilter()
%   Does the same thing as imfilter()
    O = zeros(size(I));
    F = int16(F);
    I = int16(I);
    % Determine what row/col to start, use zero padding
    eff_size = floor(size(F,1)/2);
    % WHY DOES MATLAB HAVE TO INDEX AT 1?!?!?   AHHAHHAHAHAIWHBVYIRBVUYAYC
    for row = 1+eff_size:size(I,1)-eff_size
        for col = 1+eff_size:size(I,2)-eff_size
            img_seg = I(row-eff_size:row+eff_size,col-eff_size:col+eff_size);
            O_px = sum(img_seg.*F,'all');
            % saturate
            O(row,col)=sat(O_px, 0, 255);
        end
    end
end
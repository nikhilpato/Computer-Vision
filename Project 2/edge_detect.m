function O = edge_detect(I, mode)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(mode,'sobel')
        Fx = [-1 0 1;-2 0 2;-1 0 1];
        Fy = [-1 -2 -1; 0 0 0; 1 2 1];
    elseif strcmp(mode, 'prewitt')
        Fx = [1 0 -1;1 0 -1;1 0 -1];
        Fy = [1 1 1;0 0 0;-1 -1 -1];
    end
    
    Gx = lin_img_conv(I, Fx);
    Gy = lin_img_conv(I, Fy);
    
    O = uint8(sqrt(Gx.^2 + Gy.^2));
end


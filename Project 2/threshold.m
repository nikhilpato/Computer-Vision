function O = threshold(I, threshold_val)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    O = I;
    O(O > threshold_val) = 255;
    O(O <= threshold_val) = 0;
end


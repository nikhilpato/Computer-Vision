function sat_x = sat_scalar(x, min, max)
%sat_x Saturates input value with upper and lower limits
%   Detailed explanation goes here
    if x > max
        sat_x = max;
    elseif x < min
        sat_x = min;
    else
        sat_x = x;
    end
end
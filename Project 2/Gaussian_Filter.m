function F = Gaussian_Filter(sigma_square, sz)
%GAUSSIAN_FILTER Mimics fspecial('gaussian', [sz,sz], simga).  
%   Extra Credit for creating our own Gaussian filter!
    F = zeros(sz);
    vals = (-floor(sz/2):floor(sz/2));
    for F_row = 1:size(F,1)
        for F_col = 1:size(F,2)
            x = vals(F_row);
            y = vals(F_col);
            F(F_row,F_col) = Gaussian(x, y, sigma_square);
        end
    end
    % Normalize the matrix
    F = F.*(1/sum(F, 'all'));
end

function G = Gaussian(x,y,sigma_square)
    % Extra Credit for creating our own Gaussian generator!
    G = (1/(2*pi*sigma_square)*exp(-(x*x+y*y)/(2*sigma_square)));
end

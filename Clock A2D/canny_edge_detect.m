function O = canny_edge_detect(I, sigma, threshold)
    % gaus = lin_img_conv(I, Gaussian_Filter(sigma*sigma, 5));    
    gaus = imgaussfilt(I, sigma);
    O = edge(gaus, 'Canny', threshold);
end
function O = canny_edge_detect(I, sigma_squared)
    gaus_filter = Gaussian_Filter(sigma_squared, 3);
    filtered_image = lin_img_conv(I, gaus_filter);
    O = edge(filtered_image, 'Canny');
end
function O = canny_edge_detect(I, sigma_squared, threshold)
    gaus = imgaussfilt(I, sigma_squared);
    O = edge(gaus, 'Canny', threshold);
end
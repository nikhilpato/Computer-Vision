clc
clear;
close all;

% Load images

cwd = pwd;
I_files = dir(fullfile(cwd+"/input",'*.jpg'));
I = {size(I_files,1)};

% For each image in "input" directory...
for i = 1:size(I_files,1)
    
    % Load image into image cell array (I)
    I{i} = imread("input/"+I_files(i).name);

    % Create binary image and segment so we can identify each resistor
    I_cur_gray = rgb2gray(I{i});
    
    % Create edge map
    E_map_sobel = edge_detect(I_cur_gray, 'sobel');
    
    % Identify circle which represents a clock
    % [ctr, r] = imfindcircles(I_cur_gray, [10 1000]);
    
    % Create canny edge detected map on the image after a strong gaussian
    % blur to remove fake lines
    SIGMA_SQUARE = 50;
    SIZE = 51;
    BW_THRESHOLD = 50;
    G_filt = Gaussian_Filter(SIGMA_SQUARE, SIZE);
    I_gaus = lin_img_conv(I_cur_gray, G_filt);
    I_gaus_bw = I_gaus > BW_THRESHOLD;
    E_map_canny = remove_zero_padding(edge(I_gaus_bw, 'canny'),1+floor(SIZE/2));
    
    
    % Maybe: If ellipse, use affine transformation to transfrom into circle
    
    % "12" or "6" detection with template matching to align clock facing up
    
    % Line detection w/ hough transform
    NUM_HOUGH_PEAKS = 4;
    LINE_MIN_LEN = 150;
    
    [H,H_theta,H_Rho] = hough(E_map_canny);
    
    HOUGH_THRESHOLD = ceil(0.05*max(H(:)));  % Default: 0.3*...
    
    
    H_Peaks  = houghpeaks(H, NUM_HOUGH_PEAKS, 'threshold', HOUGH_THRESHOLD);
    lines = houghlines(E_map_canny,H_theta,H_Rho,H_Peaks,...
        'FillGap',10,...
        'MinLength',LINE_MIN_LEN);
    
    % Sort lines by length
    lines_mtx = [];
    for k=1:length(lines)
        theta = lines(k).theta;
        if theta < 0
            theta = theta + 360;
        end
        lines_mtx(k,:) = [norm(lines(k).point1 - lines(k).point2) theta];
    end
    
    lines_mtx = sort(lines_mtx,'descend');
    
    figure, imshow(E_map_canny), hold on
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    end
    
    % Determine angles
    % Minute hand
    minute = floor(lines_mtx(1,2)/6);
    hour = floor(lines_mtx(2,2)/30);
    
    % Profit?
    fprintf("%d:%0.2d",hour,minute);
end 


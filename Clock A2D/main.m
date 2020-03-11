clc
clear;
close all;

% Load images

cwd = pwd;
I_files = dir(fullfile(cwd+"/input",'*.jpg'));
I = {size(I_files,1)};

% For each image in "input" directory...
% Change this to "parfor" to run them all in parallel (if you have the
% toolbox installed)
for i = 1:size(I_files,1)
    
    % Load image into image cell array (I)
    I{i} = imread("input/"+I_files(i).name);
    I_cur_gray = rgb2gray(I{i});
    
    
    % Create edge map
    E_map_sobel = edge_detect(I_cur_gray, 'sobel');
    
    % Create canny edge detected map on the image after a strong gaussian
    % blur to remove fake lines
    SIGMA_SQUARE = 50;
    SIZE = 51;
    BW_THRESHOLD = 120;
    CANNY_THRESHOLD = .5;
    G_filt = Gaussian_Filter(SIGMA_SQUARE, SIZE);
    I_gaus = lin_img_conv(I_cur_gray, G_filt);
    I_gaus_bw = I_gaus > BW_THRESHOLD;
    E_map_canny_strongBlur = remove_zero_padding(edge(I_gaus_bw, 'canny', ...
        CANNY_THRESHOLD),1+floor(SIZE/2));
    
    % Create canny edge detected map on the image after a weak gaussian
    % blur to find the clock face circle
    SIGMA_SQUARE = 2;
    SIZE = 5;
    BW_THRESHOLD = 100;
    CANNY_THRESHOLD = .5;
    G_filt = Gaussian_Filter(SIGMA_SQUARE, SIZE);
    I_gaus = lin_img_conv(I_cur_gray, G_filt);
    I_gaus_bw = I_gaus > BW_THRESHOLD;
    E_map_canny_weakBlur = remove_zero_padding(edge(I_gaus_bw, 'canny', ...
        CANNY_THRESHOLD),1+floor(SIZE/2));
    
    E_map_canny = E_map_canny_strongBlur;
    
    % Identify circle which represents a clock
    %[ctr, r] = imfindcircles(I{i}, [100 1200]);
    %imshow(E_map_canny);
    %viscircles(ctr,r);
    
    
    % Maybe: If ellipse, use affine transformation to transfrom into circle
    center = [size(E_map_canny,1)/2 size(E_map_canny,2)/2];
    
    % "12" or "6" detection with template matching to align clock facing up
    
    % Line detection w/ hough transform
    NUM_HOUGH_PEAKS = 5;
    LINE_MIN_LEN = 100;
    
    [H,H_theta,H_Rho] = hough(E_map_canny);
    
    HOUGH_THRESHOLD = ceil(0.01*max(H(:)));  % Default: 0.3*...
    
    
    H_Peaks  = houghpeaks(H, NUM_HOUGH_PEAKS, 'threshold', HOUGH_THRESHOLD);
    lines = houghlines(E_map_canny,H_theta,H_Rho,H_Peaks,...
        'FillGap',50,...
        'MinLength',LINE_MIN_LEN);
    
    % Sort lines by length
    % lines_mtx = [len,theta,[x1,x2]]
    lines_mtx = [];
    for k=1:length(lines)
        theta = lines(k).theta;
        if theta < 0
            theta = theta + 360;
        end
        lines_mtx(k,:) = [norm(lines(k).point1 - lines(k).point2) theta ...
            lines(k).point1(1) lines(k).point2(1)];
    end
    
    % Sort lines_mtx by the first column in descending order
    % From https://www.mathworks.com/matlabcentral/answers/278956-sort-
    % matrix-based-on-unique-values-in-one-column
    [~,idx] = sort(lines_mtx(:,1), 'descend'); % sort just the first column
    lines_mtx = lines_mtx(idx,:);   % sort the whole matrix using the sort indices
    
    % If we detect both sides of the hour/minute hand
    SAME_HAND_ANGLE_THRESHOLD = 5;
    numChanges = 0;
    if size(lines_mtx,1) > 2
       h=1;
       while h < size(lines_mtx,1)
           if numChanges >= 2
                break;
           end
           angleDiff = abs(lines_mtx(h,2) - lines_mtx(h+1,2));
           if (angleDiff < SAME_HAND_ANGLE_THRESHOLD)
               % Take the average of the angles
               lines_mtx(h,2) = 0.5*(lines_mtx(h,2) + lines_mtx(h+1,2));
               % Delete the next row, we don't need it
               lines_mtx(h+1,:) = [];
               
               numChanges = numChanges + 1;
           end
           h = h+1;
       end
    end
    
    figure();
    imshow(E_map_canny);
    hold on;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    end
    
    % Determine angles
    %% TODO: LOOK HERE!
    % Minute hand
    minute = floor(lines_mtx(1,2)/6);
    if (mean(lines_mtx(1,3:4)) > (center(1)) && minute > 30)
        minute = minute - 30;
    end
    if (mean(lines_mtx(1,3:4)) < (center(1)) && minute < 30)
        minute = minute + 30;
    end   
    
    
    %Hour hand
    hour = floor(lines_mtx(2,2)/30);
    if (mean(lines_mtx(2,3:4)) > (center(1)) && hour > 6)
        hour = hour - 6;
    end
    if (mean(lines_mtx(2,3:4)) < (center(1)) && hour < 6)
        hour = hour + 6;
    end
    
    if hour == 0
        hour = 12;
    end
    
    % Profit?
    time = sprintf("%d:%0.2d",hour,minute);
    disp time;
    xlabel(time);
end 


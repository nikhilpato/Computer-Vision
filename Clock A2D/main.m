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
    E_map = edge_detect(I_cur_gray, 'sobel');
    
    % Identify circle which represents a clock
    [ctr, r] = imfindcircles(I_cur_gray, [10 1000]);
    imshow(E_map,[]);
    viscircles(ctr, r,'EdgeColor','b');
    
    % Maybe: If ellipse, use affine transformation to transfrom into circle
    
    % "12" or "6" detection with template matching to align clock facing up
    
    % Line detection w/ hough transform
    
    % Determine angles
    
    % Profit?
end 


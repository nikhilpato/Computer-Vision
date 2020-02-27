clc
close all

SMALLEST_IMG_SIZE = [259 194];
SIZE_THRESHOLD = 1.5;

%% Load images and determine ROIs
% Only do this if we haven't already...
if exist('ROI','var')==0 || exist('I','var')==0
   
    % Cell array of all image mats and ROIs
    I    = {20};
    ROI = {20};

    cwd = pwd;
    I_files = dir(fullfile(cwd+"/ImgA",'*.jpg'));

    % Iterate across all images for Part A
    for i = 1:size(I_files,1)
        i_filename = I_files(i).name;
        I{i} = imread("ImgA/"+i_filename);

        % Resize if necessary
        while SIZE_THRESHOLD*size(I{i},1) > SMALLEST_IMG_SIZE(1)
            I{i} = subsample(I{i});
        end

        % Perform ROI selection
        imshow(I{i});
        ROI{i} = roipoly();
    end 
end
% Now we have all of our images and ROIs

%% Plot our historgams for the foreground and background pixels

% RGB
planeHist(I, ROI, "RGB", "Red", "Green", "Blue");

% Normalized RGB
I_nRGB = {20};
for i=1:size(I,2)
   I_nRGB{i} =  normalizeRGB(I{i});
end
planeHist(I_nRGB, ROI, "Normalized RGB", "R", "G", "B");

% HSV
I_HSV = {20};
for i=1:size(I,2)
   I_HSV{i} =  rgb2hsv(I{i});
end
planeHist(I_HSV, ROI, "HSV", "Hue", "Saturation", "Value");
clc
close all

% Parameters to help resize images to nearly the same size
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

% Extra Credit
I_YCBCR = {20};
for i=1:size(I,2)
   I_YCBCR{i} =  rgb2ycbcr(I{i});
end
planeHist(I_YCBCR, ROI, "YCbCr", ...
    "Luminance (Y)", "Chrominance (Cb)", "Chrominance (Cr)");

%% LAB is going to be a pain because I can't use my planeHist() function
%% AGGHH!
I_LAB = {20};
for i=1:size(I,2)
   I_LAB{i} =  rgb2lab(I{i});
end
% Channel histogram, I'm not going to rename them to LAB
R_obj = [];
R_bg  = [];
G_obj = [];
G_bg  = [];
B_obj = [];
B_bg  = [];
for i=1:size(I_LAB,2)
    cur_img = I_LAB{i};

    % Extract the L, A, B planes
    L = cur_img(:,:,1);
    A = cur_img(:,:,2);
    B = cur_img(:,:,3);

    % Extract the pixels of the L, A, B, planes that are masked or unmasked
    R_bg = vertcat(R_bg,L(ROI{i}==0));
    R_obj = vertcat(R_obj,L(ROI{i}==1));
    G_bg = vertcat(G_bg,A(ROI{i}==0));
    G_obj = vertcat(G_obj,A(ROI{i}==1));
    B_bg = vertcat(B_bg,B(ROI{i}==0));
    B_obj = vertcat(B_obj,B(ROI{i}==1));
end
figure()
subplot(311);
histogram(R_obj);
ylabel("L Pixels");
subplot(312);
histogram(G_obj);
ylabel("A Pixels");
subplot(313);
histogram(B_obj);
ylabel("B Pixels");
sgtitle('LAB of Strawberry Pixels')

figure()
subplot(311);
histogram(R_bg);
ylabel("L Pixels");
subplot(312);
histogram(G_bg);
ylabel("A Pixels");
subplot(313);
histogram(B_bg);
ylabel("B Pixels");
sgtitle('LAB of Background Pixels')
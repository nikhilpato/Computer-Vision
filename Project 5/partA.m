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
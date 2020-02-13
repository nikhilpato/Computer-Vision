clc;
clear;
close all;

%These variables can be changed 
sigma = 1;
hsize = 3;
alpha = 0.05;
R_threshold = 0.5;

%Choose between a gaussian filter and averaging filter by uncommenting
%either of the lines below:

weights = fspecial('gaussian', hsize, sigma);
%weights = [1/9,1/9,1/9; 1/9,1/9,1/9; 1/9,1/9,1/9];


checkerboard_image = checkerboard();
[xsize, ysize] = size(checkerboard_image);



prewitt_filter_x = [-1,0,1;-1,0,1;-1,0,1];
prewitt_filter_y = [-1,-1,-1; 0,0,0; 1,1,1];

%Apply the Horizontal and Vertical prewitt filters
Ix = imfilter(checkerboard_image, prewitt_filter_x);
Iy = imfilter(checkerboard_image, prewitt_filter_y);

%Compute the necessary components of the second moment matrix
Ix2 = imfilter(Ix.^2, weights);
IxIy = imfilter(Ix.*Iy , weights);
Iy2 = imfilter(Iy.^2, weights);

%Determinant of the second moment matrix
det_of_m = (Ix2.*Iy2) - IxIy.^2;

%Trace of the second moment matrix
trace_of_m = Ix2+Iy2;

%Calculating the R-score of the second moment matrix
R_score = det_of_m - (alpha * trace_of_m.^2);

%Applying a threshold to the R-score
thresholded = R_score > R_threshold;

%Getting the locations of white pixels in binary image
[x_locs, y_locs] = find(thresholded == 1);

%Padding the image with zeros to avoid crashing program
padded = padarray(R_score,[1 1],0,'both');

%Non maximum suppression
for i = 1:size(x_locs,1)
    neighbors = padded(x_locs(i):x_locs(i)+2, y_locs(i):y_locs(i)+2);
    max_of_neighbors = max(max(neighbors));
    if padded(x_locs(i) + 1, y_locs(i) + 1) ~= max_of_neighbors
        padded(x_locs(i) + 1, y_locs(i) + 1) = 0;
    end
end

%Removing the zero padding
harris_corner_detect = padded(2: size(padded, 1) - 1, 2: size(padded, 2) - 1);
    

BWC = bwconncomp(harris_corner_detect);
s_w = regionprops(BWC, 'Centroid', 'FilledArea');
centroids_w = cat(1,s_w.Centroid);

figure()
imshow(checkerboard_image);
for i = 1:size(centroids_w,1)
    C = centroids_w(i,:);
    rectangle('Position',[C(1) - 1,C(2) - 1,2,2],'FaceColor',[1 0 0])
end





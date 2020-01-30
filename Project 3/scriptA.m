%% Part A

I = rgb2gray(imread("go1.jpg"));
T_white = rgb2gray(imread("WhiteStone.JPG"));
T_black = rgb2gray(imread("BLackStone.JPG"));

% Perform correlation
C_white = normxcorr2(T_white, I);

% Correct the image size
size_diff_x = size(C_white,1)-size(I,1);
size_diff_y = size(C_white,2)-size(I,2);
C_white = C_white(floor(1+size_diff_x/2):floor(size(C_white,1)-size_diff_x/2),floor(1+size_diff_y/2):floor(size(C_white,2)-size_diff_y/2));

% Apply threshold to find template matches
C_white(C_white < 0.75*max(max(C_white))) = 0;
C_white(C_white > 0) = 1;

% Find centroids of template matches so we can draw boxes
cc_w = bwconncomp(C_white)
s_w = regionprops(cc_w, 'Centroid', 'FilledArea')
centroids_w = cat(1,s_w.Centroid);

imshow(I)
for i = 1:size(centroids_w,1)
    C = centroids_w(i,:);
    rectangle('Position',[C(1)-20,C(2)-15,30,30],'EdgeColor',[1 0 0])
end

% TODO:  Black Stone Detection, in report show template map before and
% after binary thresholding (for each color, and for all).


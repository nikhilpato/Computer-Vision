%% Part A
clc;
close all;

% Constants that will affect performance (these need to be manually tuned)
THRESHOLD_WHITE = 0.65;
THRESHOLD_BLACK = 0.75;

I = rgb2gray(imread("go1.jpg"));
T_white = rgb2gray(imread("WhiteStone.JPG"));
T_black = rgb2gray(imread("BLackStone.JPG"));

% Perform correlation
C_white = normxcorr2(T_white, I);
C_black = normxcorr2(T_black, I);


% Correct the image size
size_diff_x = size(C_white,1)-size(I,1);
size_diff_y = size(C_white,2)-size(I,2);
C_white = C_white(floor(1+size_diff_x/2):floor(size(C_white,1)-size_diff_x/2),floor(1+size_diff_y/2):floor(size(C_white,2)-size_diff_y/2));


size_diff_x = size(C_black,1)-size(I,1);
size_diff_y = size(C_black,2)-size(I,2);
C_black = C_black(floor(1+size_diff_x/2):floor(size(C_white,1)-size_diff_x/2),floor(1+size_diff_y/2):floor(size(C_white,2)-size_diff_y/2));

% Display the correlation map
figure();
set(gcf,'color','w');
subplot(1,2,1);
imshow(C_white,[]);
xlabel("Correlation map for white stones");
subplot(1,2,2);
imshow(C_black,[]);
xlabel("Correlation map for black stones");

% Apply threshold to find template matches
C_white(C_white < THRESHOLD_WHITE) = 0;
C_white(C_white > 0) = 1;
C_black(C_black < THRESHOLD_BLACK) = 0;
C_black(C_black > 0) = 1;

% Find centroids of template matches so we can draw boxes
cc_w = bwconncomp(C_white);
s_w = regionprops(cc_w, 'Centroid', 'FilledArea');
centroids_w = cat(1,s_w.Centroid);
cc_b = bwconncomp(C_black);
s_b = regionprops(cc_b, 'Centroid', 'FilledArea');
centroids_b = cat(1,s_b.Centroid);

% Show the figure, draw the boxes around the centroids
figure();
imshow(imread("go1.jpg"));
for i = 1:size(centroids_w,1)
    C = centroids_w(i,:);
    rectangle('Position',[C(1)-20,C(2)-15,35,32],'EdgeColor',[1 0 0])
end
for i = 1:size(centroids_b,1)
    C = centroids_b(i,:);
    rectangle('Position',[C(1)-17,C(2)-10,35,32],'EdgeColor',[0 1 0])
end


%% Computer Vision Project 1
%  Alec Hardy and Nikhil Patolia
%  1/9/2020

clc;
close all;
clearvars;

%% Part A

% Read and Display the image
im1 = imread('landscape.jpg');
im2 = imread('group.jpg');

figure();
imshow(im1);
xlabel("Figure 1. Landscape original image. Color");

figure();
imshow(im2);
xlabel("Figure 2. Group original image. Color");


% Convert the image to grayscale
im1_g = rgb2gray(im1);
im2_g = rgb2gray(im2);

max1 = max(max(im1_g));
max1 = max1(1);
[Xmax1, Ymax1] = find(im1_g==max1);
max2 = max(max(im2_g));
max2 = max2(1);
[Xmax2, Ymax2] = find(im2_g==max2);

min1 = min(min(im1_g));
min1 = min1(1);
[Xmin1, Ymin1] = find(im1_g==min1);
min2 = min(min(im2_g));
min2 = min2(1);
[Xmin2, Ymin2] = find(im2_g==min2);

fprintf('Image 1: Max Pixel Val: %3d (%.3f); Location: (%d, %d)\n', max1, double(max1)/255, Xmax1(1), Ymax1(1));
fprintf('         Min Pixel Val: %3d (%.3f); Location: (%d, %d)\n\n', min1, double(min1)/255, Xmin1(1), Ymin1(1));

fprintf('Image 2: Max Pixel Val: %3d (%.3f); Location: (%d, %d)\n', max2, double(max2)/255, Xmax2(1), Ymax2(1));
fprintf('         Min Pixel Val: %3d (%.3f); Location: (%d, %d)\n\n', min2, double(min2)/255, Xmin2(1), Ymin2(1));


% Record filesize and comment on quality
fprintf('Image 1 grayscale (UINT8) size: %d bytes\n', size(im1_g,1)*size(im1_g,2));
fprintf('Image 2 grayscale (UINT8) size: %d bytes\n', size(im2_g,1)*size(im2_g,2));

% Reduce the quality of each image a bunch of times
img1_c1 = halve_mat(im1_g);
img1_c2 = halve_mat(img1_c1);
img1_c3 = halve_mat(img1_c2);
img1_c4 = halve_mat(img1_c3);
img1_c5 = halve_mat(img1_c4);
img1_c6 = halve_mat(img1_c5);
figure();
imshow(im1_g);
xlabel("Figure 3. Landscape original image.  No resolution change. 742x990");
figure();
imshow(imresize(img1_c1, 2));
xlabel("Figure 4. Landscape image, resolution halved once. 371x495");
figure();
imshow(imresize(img1_c2, 4));
xlabel("Figure 5. Landscape image, resolution halved twice. 186x248");
figure();
imshow(imresize(img1_c3, 8));
xlabel("Figure 6. Landscape image, resolution halved thrice. 93x124");
figure();
imshow(imresize(img1_c4, 16));
xlabel("Figure 7. Landscape image, resolution halved 4x. 47x62");
figure();
imshow(imresize(img1_c5, 32));
xlabel("Figure 8. Landscape image, resolution halved 5x. 24x31");
figure();
imshow(imresize(img1_c6, 64));
xlabel("Figure 9. Landscape image, resolution halved 6x. 12x16");

% Next image
img2_c1 = halve_mat(im2_g);
img2_c2 = halve_mat(img2_c1);
img2_c3 = halve_mat(img2_c2);
img2_c4 = halve_mat(img2_c3);
img2_c5 = halve_mat(img2_c4);
img2_c6 = halve_mat(img2_c5);
figure();
imshow(im2_g);
xlabel("Figure 10. Group original image.  No resolution change. 720x1280");
figure();
imshow(imresize(img2_c1, 2));
xlabel("Figure 11. Group image, resolution halved once. 360x640");
figure();
imshow(imresize(img2_c2, 4));
xlabel("Figure 12. Group image, resolution halved twice. 180x320");
figure();
imshow(imresize(img2_c3, 8));
xlabel("Figure 13. Group image, resolution halved thrice. 90x160");
figure();
imshow(imresize(img2_c4, 16));
xlabel("Figure 14. Group image, resolution halved 4x. 45x80");
figure();
imshow(imresize(img2_c5, 32));
xlabel("Figure 15. Group image, resolution halved 5x. 23x40");
figure();
imshow(imresize(img2_c6, 64));
xlabel("Figure 16. Group image, resolution halved 6x. 12x20");

fprintf('Image 1 grayscale (UINT8) size: %d bytes\n', size(im1_g,1)*size(im1_g,2));
fprintf('Image 2 grayscale (UINT8) size: %d bytes\n', size(im2_g,1)*size(im2_g,2));
%% Part B

im17 = imread('bacteria.bmp');
figure();
imshow(im17);
xlabel("Figure 17. Original Image of Bacteria.");

BW = im17 > 100;
figure();
imshow(BW);
area = sum(~BW(:));

fprintf("Total area of bacteria: %d pixels\n", area);

labels = bwlabel(~BW);

groups = regionprops(labels, 'Centroid', 'FilledArea');
imshow(BW)
xlabel("Figure 18. Labelled Image of Bacteria.");
for num = 1:numel(groups)
    coordinate = groups(num).Centroid;
    text(coordinate(1), coordinate(2), int2str(num), 'Color', 'red');
    fprintf("Area of bacteria #%d is %d\n", num, groups(num).FilledArea);
end


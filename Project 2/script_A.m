clc;

I = rgb2gray(imread('corridor.jpg'));
F = [1 2 3 4 5; 4 5 6 4 5; 7 8 9 4 5; 4 5 6 4 5; 7 8 9 4 5];
O = lin_img_conv(I,F);

imshow(O);
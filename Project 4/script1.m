%% Write a program to implement Harris corner detection. 
%  Don’t use any built-in function for this part. Test your program on the 
%  checkerboard image from MATLAB and overlay the detected corners on the 
%  image using red squares. Describe your effort in tweaking the parameters 
%  (such as Gaussian filter size, threshold value for validating a corner).

clc;
close all;

checkerboard_image = checkerboard();
imshow(checkerboard_image);
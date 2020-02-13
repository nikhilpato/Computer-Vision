%% Feature Description:
%  Write a function that extract the feature vector from the detected 
%  keypoints. The function should have the format:
%  [extracted_features] = my_extractFeatures_a/b(image, detected_pts)
%  For this part, you can use MATLAB’s built-in feature detectors 
%  (such as FAST, SURF) to detect keypoints. Limit the number of detected 
%  keypoints to no more than 100 per image.
%   a. First use raw pixel data in a small square window (say 5x5) around 
%      the keypoint as the feature descriptor. This should work well when 
%      the images you are comparing are related by only a translation.
%   b. Next, implement a SIFT-like feature descriptor. You do not need to 
%      implement the full SIFT (for example no orientation normalization if
%      no rotation is involved).


clear all;
close all;

%% Let's get started
I = rgb2gray(imread('bikes1.ppm'));
fp = myDetectHarrisFeatures(I);

ex_a = my_extractFeatures_a(I, fp);
ex_b = my_extractFeatures_b(I, fp);
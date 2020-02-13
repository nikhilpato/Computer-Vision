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


clear;
close all;

%% Let's get started
I1 = rgb2gray(imread('bikes1.ppm'));
I2 = rgb2gray(imread('bikes2.ppm'));
I3 = rgb2gray(imread('cars1.ppm'));
I4 = rgb2gray(imread('cars2.ppm'));
I5 = rgb2gray(imread('wall1.ppm'));
I6 = rgb2gray(imread('wall2.ppm'));

% Feature points in [x,y] coordinates
fp1 = selectStrongest(detectFASTFeatures(I1),100).Location;
fp2 = selectStrongest(detectFASTFeatures(I2),100).Location;
fp3 = selectStrongest(detectFASTFeatures(I3),100).Location;
fp4 = selectStrongest(detectFASTFeatures(I4),100).Location;
fp5 = selectStrongest(detectFASTFeatures(I5),100).Location;
fp6 = selectStrongest(detectFASTFeatures(I6),100).Location;

% Extracted feature vectors
% ef(row_num) corresponds to the location in fp(row_num)
ef_1a = my_extractFeatures_a(I1, fp1);
ef_2a = my_extractFeatures_a(I2, fp2);
ef_3a = my_extractFeatures_a(I3, fp3);
ef_4a = my_extractFeatures_a(I4, fp4);
ef_5a = my_extractFeatures_a(I5, fp5);
ef_6a = my_extractFeatures_a(I6, fp6);

% ex_1b = my_extractFeatures_b(I1, fp1);
% ex_2b = my_extractFeatures_b(I2, fp2);

% Returns [fp1,fp2] ordered by matching points
[~,fp_match_2] = bestMatch(fp1, ef_1a, fp2, ef_2a, 1);
[~,fp_match_4] = bestMatch(fp3, ef_3a, fp4, ef_4a, 1);
[~,fp_match_6] = bestMatch(fp5, ef_5a, fp6, ef_6a, 1);

figure();
showMatchedFeatures(I1, I2, fp1, fp_match_2);
figure();
showMatchedFeatures(I3, I4, fp3, fp_match_4);
figure();
showMatchedFeatures(I5, I6, fp5, fp_match_6);
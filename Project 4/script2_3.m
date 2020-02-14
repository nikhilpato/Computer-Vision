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

%% Extract feature points
% Feature points in [x,y] coordinates
% The selectedStrongest(N) value is chosen manually such that there are not
% more than 100 FP matches after performing the bestMatch() function.
fp1 = selectStrongest(detectFASTFeatures(I1),200).Location;
fp2 = selectStrongest(detectFASTFeatures(I2),200).Location;
fp3 = selectStrongest(detectFASTFeatures(I3),200).Location;
fp4 = selectStrongest(detectFASTFeatures(I4),200).Location;
fp5 = selectStrongest(detectFASTFeatures(I5),400).Location;
fp6 = selectStrongest(detectFASTFeatures(I6),400).Location;

%% Extracted feature vectors
% ef(row_num) corresponds to the location in fp(row_num)

% Use SIFT-like feature extraction algorithm
ef_1 = my_extractFeatures_b(I1, fp1, fspecial('gaussian', 5, 1));
ef_2 = my_extractFeatures_b(I2, fp2, fspecial('gaussian', 5, 1));
ef_3 = my_extractFeatures_b(I3, fp3, fspecial('gaussian', 3, .5));
ef_4 = my_extractFeatures_b(I4, fp4, fspecial('gaussian', 3, .5));
ef_5 = my_extractFeatures_b(I5, fp5, fspecial('gaussian', 3, .5));
ef_6 = my_extractFeatures_b(I6, fp6, fspecial('gaussian', 3, .5));

% Use crappy neighboring raw-pixel values
ef_1b = my_extractFeatures_a(I1, fp1);
ef_2b = my_extractFeatures_a(I2, fp2);
ef_3b = my_extractFeatures_a(I3, fp3);
ef_4b = my_extractFeatures_a(I4, fp4);
ef_5b = my_extractFeatures_a(I5, fp5);
ef_6b = my_extractFeatures_a(I6, fp6);

%% Returns [fp1,fp2] ordered by matching points
% Using the basic neighboring raw-pixel descriptor
[fp_match_1b,fp_match_2b] = bestMatch(fp1, ef_1b, fp2, ef_2b, .75);
[fp_match_3b,fp_match_4b] = bestMatch(fp3, ef_3b, fp4, ef_4b, .75);
[fp_match_5b,fp_match_6b] = bestMatch(fp5, ef_5b, fp6, ef_6b, .8);

% Using SIFT-like descriptor
[fp_match_1,fp_match_2] = bestMatch(fp1, ef_1, fp2, ef_2, .5);
[fp_match_3,fp_match_4] = bestMatch(fp3, ef_3, fp4, ef_4, .6);
[fp_match_5,fp_match_6] = bestMatch(fp5, ef_5, fp6, ef_6, .6);

%% Display everything
figure();
set(gcf,'color','w');
subplot(2, 1, 1);
showMatchedFeatures(I1, I2, fp_match_1b, fp_match_2b, 'montage');
xlabel(["Feature matching using neighboring pixel feature descriptor","Matching ratio threshold: 0.75"]);
subplot(2, 1, 2);
showMatchedFeatures(I1, I2, fp_match_1, fp_match_2, 'montage');
xlabel(["Feature matching using SIFT-like feature descriptor","Matching ratio threshold: 0.5"]);

figure();
set(gcf,'color','w');
subplot(2, 1, 1);
showMatchedFeatures(I3, I4, fp_match_3b, fp_match_4b, 'montage');
xlabel(["Feature matching using neighboring pixel feature descriptor","Matching ratio threshold: 0.75"]);
subplot(2, 1, 2);
showMatchedFeatures(I3, I4, fp_match_3, fp_match_4, 'montage');
xlabel(["Feature matching using SIFT-like feature descriptor","Matching ratio threshold: 0.6"]);

figure();
set(gcf,'color','w');
subplot(2, 1, 1);
showMatchedFeatures(I5, I6, fp_match_5b, fp_match_6b, 'montage');
xlabel(["Feature matching using neighboring pixel feature descriptor","Matching ratio threshold: 0.8"]);
subplot(2, 1, 2);
showMatchedFeatures(I5, I6, fp_match_5, fp_match_6, 'montage');
xlabel(["Feature matching using SIFT-like feature descriptor","Matching ratio threshold: 0.6"]);
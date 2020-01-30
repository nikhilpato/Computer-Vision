%% Part A

I = rgb2gray(imread("go1.jpg"));
T_white = rgb2gray(imread("WhiteStone.JPG"));
T_black = rgb2gray(imread("BLackStone.JPG"));

% Perform correlation
C_white = normxcorr2(T_white, I);

%Correct the image size
size_diff = size(C_white,1)-size(I,1);
row1 = size_diff/2;
row2 = size(C_white,1)-size_diff/2
C_white = C_white(row1:row2,size_diff/2:size(C_white,2)-size_diff/2)


C_white_t = threshold(C_white,0.5);
imshow(C_white_t,[])
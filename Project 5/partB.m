clc
close all
clear

I = {6};

cwd = pwd;
I_files = dir(fullfile(cwd+"/ImgB",'*.jpg'));

% Iterate across all images for Part B
for i = 1:size(I_files,1)
    i_filename = I_files(i).name;
    I{i} = imread("ImgB/"+i_filename);
end


for x = 1:6
    og = I{x};
    [row, col] = size(og);
    %Preprocess the image by Gaussian Filtering the image
    sizeBasedNum = round((row * col)^(0.23), 0);
    gaussianFilt = fspecial('gaussian', sizeBasedNum, 4);
    rgbImage = imfilter(og, gaussianFilt);


    
    %Choose the number of different K groups
    numKClasses = cast(sizeBasedNum * 0.7, 'uint8');
    k_vals = imsegkmeans(rgbImage,numKClasses);
    maxRed = 0;
    for n = 1 : numKClasses
        %For each K Group
        thisClass = k_vals == n;
        %Mask the original image over the parts over the K Group
        maskedRgbImage = bsxfun(@times, rgbImage, cast(thisClass, 'like', rgbImage));
        %See how many pixels are strawberry colored.  The one with the
        %highest count of strawberry colored pixels is chosen as the K
        %Group
        redPoints = maskedRgbImage(:,:,1)>=130 & maskedRgbImage(:,:,2)<=60 & maskedRgbImage(:,:,3)<=100;
        tempRed = sum(sum(redPoints));
        if tempRed > maxRed
            maxRed = tempRed;
            maxRedImage = thisClass;
            dur = maskedRgbImage;
        end
    end
    

    % Get connected components with area and bounding box
    rp = regionprops(maxRedImage, 'Area', 'BoundingBox');
    % Sort the connected components by area, descending
    [~, ind] = sort([rp.Area], 'descend');
    rp = rp(ind);

    figure();
    imshow(og);
    %The maxArea is the first in the list
    maxArea = rp(1).Area;
    i = 1;
    while i < length(rp)
        %Stop when you find a connected group that is 20% of the largest
        %strawberry
        currentArea = rp(i).Area;
        if currentArea < maxArea * 0.2
            break;
        end
        bb = rp(i).BoundingBox;
        %Counting number
        text(bb(1) + 5, bb(2) + 5, int2str(i) ,'Color', 'white', 'BackgroundColor', 'black', 'FontSize', 12, 'HorizontalAlignment','left','VerticalAlignment','top')
        %Box strawberry in white box
        rectangle('Position', [bb(1), bb(2), bb(3), bb(4)] ,'EdgeColor',[1 1 1], 'LineWidth' , 2)
        i = i + 1;
    end
    %Caption the image showing how many strawberries are in the image
    caption = sprintf("There are %d strawberries in this image", i - 1);
    text(0, 0, caption ,'Color', 'white', 'BackgroundColor', 'black', 'FontSize', 12, 'HorizontalAlignment','left','VerticalAlignment','top')
end








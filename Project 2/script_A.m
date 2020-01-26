clc;

I1 = imread('Boat2.tif');
I2 = imread('building.gif');

figure();
set(gcf,'color','w');
for col = (0:1)
    if col==0
        I = I1;
    elseif col==1
        I = I2;
    end
    
    numCols = 7;
    
    subplot(2,numCols,(numCols*col)+1);
    imshow(I);
    xlabel("Original Image.")
    
    subplot(2,numCols,(numCols*col)+2);
    imshow(lin_img_conv(I, 1/9.*[1 1 1;1 1 1;1 1 1]), []);
    xlabel("Averaging Filter 3x3.")
    
    subplot(2,numCols,(numCols*col)+3);
    imshow(lin_img_conv(I, 1/25.*[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1]), []);
    xlabel("Averaging Filter 5x5.")
    
    subplot(2,numCols,(numCols*col)+4);
    imshow(lin_img_conv(I, Gaussian_Filter(.25, 3)),[]);
    xlabel("Gaussian Filter, sigma = 0.5.")
    
    subplot(2,numCols,(numCols*col)+5);
    imshow(lin_img_conv(I, Gaussian_Filter(1, 5)),[]);
    xlabel("Gaussian Filter, sigma = 1.")
    
    subplot(2,numCols,(numCols*col)+6);
    imshow(Median_Filter(I, 3),[]);
    xlabel("Median (non-lin) 3x3 Filter.")
    
    subplot(2,numCols,(numCols*col)+7);
    imshow(Median_Filter(I, 5),[]);
    xlabel("Median (non-lin) 5x5 Filter.")
end
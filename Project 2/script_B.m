I1 = rgb2gray(imread('corner_window.jpg'));
I2 = rgb2gray(imread('corridor.jpg'));
I3 = rgb2gray(imread('New York City.jpg'));
I4 = rgb2gray(imread('bike-lane.jpg'));

edgeDisplay(I1, I2, I3, I4, 'sobel');
edgeDisplay(I1, I2, I3, I4, 'prewitt');

function edgeDisplay(I1, I2, I3, I4, mode)
    figure('Name', mode);
    set(gcf,'color','w');
    for col = (0:3)
        if col==0
            I = I1;
        elseif col==1
            I = I2;
        elseif col==2
            I = I3;
        elseif col==3
            I=I4;
        end
        E1 = edge_detect(I, mode);
        subplot(4,4,(4*col)+1);
        imshow(I);
        xlabel("Original image.")
        subplot(4,4,(4*col)+2);
        imshow(E1);
        xlabel("Sum of squared gradient matrix.")
        subplot(4,4,(4*col)+3);
        t = max(E1(:))*.35;
        imshow(threshold(E1, t));
        xlabel("Threshold 35% of max ("+t+").")
        subplot(4,4,(4*col)+4);
        t = max(E1(:))*.15;
        imshow(threshold(E1, t));
        xlabel("Threshold 15% of max ("+t+").")
    end
end
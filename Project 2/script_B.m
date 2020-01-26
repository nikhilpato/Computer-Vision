I1 = rgb2gray(imread('corner_window.jpg'));
I2 = rgb2gray(imread('corridor.jpg'));
I3 = rgb2gray(imread('New York City.jpg'));
I4 = rgb2gray(imread('bike-lane.jpg'));

edgeDisplay(I1, I2, I3, I4, 'sobel');
edgeDisplay(I1, I2, I3, I4, 'prewitt');
LoGDisplay(I1, I2, I3, I4);
cannyDisplay(I1, I2, I3, I4);
houghDisplay(I1, I2, I3, I4);

function edgeDisplay(I1, I2, I3, I4, mode)
    figure('Name', mode);
    set(gcf,'color','w');
    for col = (0:3)
        % I'm still salty that MATLAB indexes at 1...but not this time!
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

function LoGDisplay(I1, I2, I3, I4)
    mode = 'LoG';
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
        s1 = edge_detect(I, mode, 1);
        s2 = edge_detect(I, mode, 3);
        s3 = edge_detect(I, mode, 5);
        subplot(4,4,(4*col)+1);
        imshow(I);
        xlabel("Original image.")
        subplot(4,4,(4*col)+2);
        imshow(s1);
        xlabel("Sigma^2 = 1")
        subplot(4,4,(4*col)+3);
        imshow(s2);
        xlabel("Sigma^2 = 3")
        subplot(4,4,(4*col)+4);
        imshow(s3);
        xlabel("Sigma^2 = 5")
    end
end

function cannyDisplay(I1, I2, I3, I4)
    figure('Name', 'Canny');
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
        E1 = canny_edge_detect(I,3, 0.1);
        E2 = canny_edge_detect(I,3, 0.3);
        E3 = canny_edge_detect(I,5, 0.1);
        E4 = canny_edge_detect(I,5, 0.3);
        subplot(5,5,(5*col)+1);
        imshow(I);
        xlabel("Original image.")
        subplot(5,5,(5*col)+2);
        imshow(E1);
        xlabel("\sigma^2 = 3. Threshold of 0.1")
        subplot(5,5,(5*col)+3);
        imshow(E2);
        xlabel("\sigma^2 = 3. Threshold of 0.3")
        subplot(5,5,(5*col)+4);
        imshow(E3);
        xlabel("\sigma^2 = 5. Threshold of 0.1")
        subplot(5,5,(5*col)+5);
        imshow(E4);
        xlabel("\sigma^2 = 5. Threshold of 0.3")
    end
end

function houghDisplay(I1, I2, I3, I4)
    %% Generate edge maps using Canny Edge Detector
    % These canny paramaters were selected from the "Best of Canny Edge
    % Detection" part of the write-up.  Definately not arbitrary.
    E1 = canny_edge_detect(I1, 5, 0.1);
    E2 = canny_edge_detect(I2, 5, 0.1);
    E3 = canny_edge_detect(I3, 3, 0.3);
    E4 = canny_edge_detect(I4, 5, 0.1);
    
    %% Display Stuff...
    figure();
    set(gcf,'color','w');
    
    % Display all of the original images
    subplot(4,2,1);
    imshow(I1);
    subplot(4,2,3);
    imshow(I2);
    subplot(4,2,5);
    imshow(I3);
    subplot(4,2,7);
    imshow(I4);
    
    %% Let's do all the crazy Hough stuff here, and display it as we go.
    for crazy_hough_stuff = (0:3)
       if crazy_hough_stuff == 0
           E = E1;
           I = I1;
           threshold = 30;
           numPeaks = 50;
           fillgap = 8;
           minlen = 15;
           subplot(4,2,2);
       elseif crazy_hough_stuff == 1
           E = E2;
           I = I2;
           threshold = 30;
           numPeaks = 50;
           fillgap = 10;
           minlen = 15;
           subplot(4,2,4);
       elseif crazy_hough_stuff == 2
           E = E3;
           I = I3;
           threshold = 30;
           numPeaks = 50;
           fillgap = 20;
           minlen = 15;
           subplot(4,2,6);
       else
           E = E4;
           I = I4;
           threshold = 30;
           numPeaks = 50;
           fillgap = 10;
           minlen = 20;
           subplot(4,2,8);
       end
       
        % I wish I had a bit more time to make my own hough() function for
        % extra credit :(
        [H, theta, rho] = hough(E);
        peaks = houghpeaks(H,numPeaks,'Threshold', threshold);
        lines = houghlines(E, theta, rho, peaks, 'FillGap', fillgap, 'minLen', minlen);
       
        imshow(I), hold on;
        for k=1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1), xy(:,2), 'LineWidth', 1, 'Color', 'r'), hold on;
        end
    end
end
function planeHist(I, ROI, name, redName, greenName, blueName)
%PLOTPLANES Summary of this function goes here

    %% Draw histograms for the RGB spaces

    % Channel histogram
    R_obj = [];
    R_bg  = [];
    G_obj = [];
    G_bg  = [];
    B_obj = [];
    B_bg  = [];
    for i=1:size(I,2)
        cur_img = I{i};

        % Extract the R, G, B planes
        R = cur_img(:,:,1);
        G = cur_img(:,:,2);
        B = cur_img(:,:,3);

        % Extract the pixels of the R, G, B, planes that are masked or unmasked
        R_bg = vertcat(R_bg,R(ROI{i}==0));
        R_obj = vertcat(R_obj,R(ROI{i}==1));
        G_bg = vertcat(G_bg,G(ROI{i}==0));
        G_obj = vertcat(G_obj,G(ROI{i}==1));
        B_bg = vertcat(B_bg,B(ROI{i}==0));
        B_obj = vertcat(B_obj,B(ROI{i}==1));
    end

    figure()
    subplot(311);
    imhist(R_obj);
    ylabel(redName + " Pixels");
    subplot(312);
    imhist(G_obj);
    ylabel(greenName + " Pixels");
    subplot(313);
    imhist(B_obj);
    ylabel(blueName + " Pixels");
    sgtitle(name + ' Histogram of Strawberry Pixels')

    figure()
    subplot(311);
    imhist(R_bg);
    ylabel("Red Pixels");
    subplot(312);
    imhist(G_bg);
    ylabel("Green Pixels");
    subplot(313);
    imhist(B_bg);
    ylabel("Blue Pixels");

    sgtitle(name + ' Histogram of Background Pixels')

end


function [extracted_features] = my_extractFeatures_b(image, detected_points, gaussian_filt)
% Part B - Nikhil
 

padded = padarray(image,[8 8],0,'both');
%need to do gaussian on the 16x16 grid
extracted_features = zeros(size(detected_points,1), 128);

for i = 1:size(detected_points, 1)
    x_loc = detected_points(i,2) + 8;
    y_loc = detected_points(i,1) + 8;

    temp = padded(x_loc - 7 : x_loc + 8, y_loc - 7: y_loc + 8);
    grid16x16 = imfilter(temp,gaussian_filt);
    [Gmag, Gdir] = imgradient(grid16x16,'sobel');
    new_dir = wrapTo360(Gdir);
    round_values = [0,45,90,135,180,225,270,315,360];
    directionals = interp1(round_values, round_values, new_dir,'nearest');


    dirs_in_cells = mat2cell(directionals, [4 4 4 4], [4 4 4 4]);
    mags_in_cells = mat2cell(Gmag, [4 4 4 4], [4 4 4 4]);

    for row = 1:4
        for col = 0:3
            default_pos = ((row - 1) * 32) + (col * 8);
            for each_pixel_dir = 1:16
                pixel_dir = dirs_in_cells{row + (col * 4)}(each_pixel_dir);

                if pixel_dir == 0 || pixel_dir == 360
                    pos = 1;
                elseif pixel_dir == 45
                    pos = 2;
                elseif pixel_dir == 90
                    pos = 3;
                elseif pixel_dir == 135
                    pos = 4;
                elseif pixel_dir == 180
                    pos = 5;
                elseif pixel_dir == 225
                    pos = 6;
                elseif pixel_dir == 270
                    pos = 7;
                else
                    pos = 8;
                end
                extracted_features(i, default_pos + pos) = ...
                    extracted_features(i, default_pos + pos) + ...
                    mags_in_cells{row + (col * 4)}(each_pixel_dir);
            end
        end
    end 
end



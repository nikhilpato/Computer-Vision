function [extracted_features] = my_extractFeatures_a(image, detected_pts)

    % Pre-allocate extracted_features
    extracted_features = zeros(size(detected_pts,1),25);

    % Iterate through each of the extracted features
    for i = 1:size(detected_pts)
        x = floor(detected_pts(i,1));
        y = floor(detected_pts(i,2));
        try
            window = image(y-2:y+2,x-2:x+2);
        catch
            % Feature is on an edge or corner so I can't grab the entire
            % 5x5 window of neighbors.  Let's use zero padding in this
            % wierd, convoluted way.  It works.
            window = zeros(5,5);
            for w_x = 1:5
                for w_y = 1:5
                    if x+(w_x-3)>2 && y+(w_y-3)>2 && ...
                            x+(w_x-3) < size(image,1) && ...
                            y+(w_y-3) < size(image,2)
                        window(w_x,w_y) = image(x+(w_x-3),y+(w_y-3));
                    end
                end
            end
        end
        % Okay, at this point we have our 5x5 window.  Phew.
        row = reshape(window,1,[]); 
        extracted_features(i,:) = row;
    end
end


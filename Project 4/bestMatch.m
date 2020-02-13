function [fp_o1,fp_o2] = bestMatch(fp1, ef_1, fp2, ef_2, null_ratio)

    fp_o1 = fp1;
    fp_o2 = zeros(size(fp1,1),2);
    
    for i=1:size(ef_1,1)
        
        % Determine the distances for the current feature point in image 1
        % and compare against every feature point in image 2
        distances = zeros(min(size(fp1,1),size(fp2,1)),1);
        for j=1:size(ef_2,1)
            d = fpDist(ef_1(i,:),ef_2(j,:));
            distances(j) = d;
        end
        
        % See what the lowest and second lowest distances are
        [smallest_1, smallest_index] = min(distances);
        smallest_2 = min(setdiff(distances,smallest_1));
        ratio = smallest_1/smallest_2;
        % If we fail the ratio test, return NULL for this fp
        if ratio > null_ratio
            fp_o2(i,:) = ["NULL","NULL"];
            continue;
        end
        
        fp_o2(i,:) = fp2(smallest_index,:);
        
    end

end

function D = fpDist(fp1, fp2)
    % Returns the Euclidean distance between the two vectors
    D = norm(fp2-fp1);
end


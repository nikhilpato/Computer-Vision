function [ halved_mat ] = halve_mat( mat_input )
%Returns a "compressed" copy of the input image matrix
    halved_mat = mat_input(1:2:end,1:2:end);
end


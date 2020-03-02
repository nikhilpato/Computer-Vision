clc
close all

%% Parameters for the generation of the 5 random cluster points
% Vary the means and covariance matrices of the distributions as well as 
% the number of points in each cluster.
NUM_CLUSTERS = 5;
NUM_PTS   = [100, 10, 300, 91, 1000];
MU_PTS    = [0, -5, 66, 7, -22];
SIGMA_PTS = [1, 2, 7, 12, 300]; 

%% Generate 2D clusters with different number of pts, means, and covariances
clusters = {NUM_CLUSTERS};
for i=1:5
    clusters{i} = [mvnrnd(MU_PTS(i), SIGMA_PTS(i), NUM_PTS(i)) ...
                   mvnrnd(MU_PTS(i), SIGMA_PTS(i), NUM_PTS(i))];
end

%% Run K-Means on the synthetic data generated in Step1. 
% Does it always yield the optimal configuration? Discuss the results.
K_SIZES = [2 3 5];
for c=1:NUM_CLUSTERS
   figure();
   for i=1:size(K_SIZES,2)
       subplot(3,1,i);
       [IDX,C] = kmeans(clusters{c},K_SIZES(i));
       scatter(clusters{c}(:,1),clusters{c}(:,2),[],IDX,'filled');
       ylabel(K_SIZES(i) + " clusters");
   end
   sgtitle(sprintf("%d Data Points\n  (\\mu=%d.  \\sigma = %d)", ...
       NUM_PTS(c), MU_PTS(c), SIGMA_PTS(c)));
end
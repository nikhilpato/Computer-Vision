clc
close all

%% Parameters for the generation of the 5 random cluster points
% Vary the means and covariance matrices of the distributions as well as 
% the number of points in each cluster.
NUM_CLUSTERS = 5;
NUM_PTS   = [100, 10, 30, 91, 50];
MU_PTS    = {[0 0],[1 -1],[15 -4],[.1 -6],[6 -7]};
SIGMA_PTS = {[1 0;0 1],[1 .75;.75 2],[2 -.1;-.1 .1],[.1 -.3;-.3 2],[5 .65;.65 1]}; 

%% Generate 2D clusters with different number of pts, means, and covariances
clusters = [];
for i=1:5
    clusters = [clusters; mvnrnd(MU_PTS{i}, SIGMA_PTS{i}, NUM_PTS(i))];                
end

%% Run K-Means on the synthetic data generated in Step1. 
% Does it always yield the optimal configuration? Discuss the results.
K_SIZES = [2 3 4 5];

for i=1:size(K_SIZES,2)
   figure();
   [IDX,C] = kmeans(clusters,K_SIZES(i));
   scatter(clusters(:,1),clusters(:,2),[],IDX,'filled');
   title(K_SIZES(i)+" K-clusters");
end


for i=1:size(K_SIZES,2)
    gmm = fitgmdist(clusters,K_SIZES(i));
    em_idx = cluster(gmm, clusters);
    figure()
    gscatter(clusters(:,1), clusters(:,2), em_idx)
    title(K_SIZES(i)+" EM-clusters");
end
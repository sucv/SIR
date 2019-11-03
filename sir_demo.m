clear;
close all;
addpath(genpath('..\sir\'));

load data;
tau_0 = 1; tau = 1.3; 

% Establish the universal set and putative inlier set.
[S_x, S_y, I_0, reOrderIdx] = NNDR(fs, ft, ds, dt, tau_0, tau);  

config.eta = 0.5;            % TPS smoothness
config.K=5;                  % Number of nearest inliers
config.rad=5;     			 % Bins on the radial direction
config.tan=12;               % Bins on the tangential direction
config.epsilon =0.001;       % Threshold for pruning
config.lambda =1.2;          % Threshold for CALM
config.omega = 1;			 % Strength for inter-neighborhood distance
config.retrieval = 1;		 % Whether to perform the retrieval
config.verbose=1;            % Whether to show logs
tic;
[Output]=sir_main(S_x, S_y, I_0, reOrderIdx, config);
time = toc;

SirIndex = Output.index;
[recall, precision, f1Score, TP, FP, TN, FN] = computeMatchingRatio(inlierIndex, SirIndex, size(S_x, 1));
disp(['SIR: recall = ' num2str(recall) ', precision = ' num2str(precision) ', f1-Score = ' num2str(f1Score) '.']);
showFeatureMatching(image_s, image_t, S_x, S_y, TP, FP, TN, FN);


thetaAst = Output.param;
source = Output.I_x; 
normal = Output.normal;
transformedI_x = sir_transform(source, landmarkIs, thetaAst, normal);
[rmse, mae, mee] = computeError(transformedI_x, landmarkIt);
disp(['SIR RMSE: ' num2str(rmse) '; MAE: ' num2str(mae) '; MEE: ' num2str(mee) '; runtime = ' num2str(time) '.']);
showImageRegistration(image_s, image_t, S_x, S_y, landmarkIs, landmarkIt, SirIndex);
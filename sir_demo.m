clear;
close all;

load data;
% Three thresholds are used. Loose and Fine are for SIR, while Default
% is for other methods.
tau_0 = 1; tau = 1.3; 

% Extract and reorder SIFT features. The reorder is required
% for SIR to function. If 1 is indicated for extraction, all overlapped
% features are removed.
[S_x, S_y, I_0, reOrderIdx] = NNDR(fs, ft, ds, dt, tau_0, tau);  

config.eta = 0.5;            % TPS smoothness
config.K=5;                         % Number of nearest inliers
config.rad=5;     
config.tan=12;               % Radial and tangential directions of CALM 
config.epsilon =0.001;        % Threshold for pruning
config.lambda =1.2;   %Threshold for CALM
config.omega = 1;
config.retrieval = 1;
config.verbose=1;                       % set to 1 for visualization.
tic;
[Output]=sir_main(S_x, S_y, I_0, reOrderIdx, config);
time = toc;

SirIndex = Output.index;
[recall, precision, f1Score, TP, FP, TN, FN] = computeMatchingRatio(inlierIndex, SirIndex, size(S_x, 1));
showFeatureMatching(image_s, image_t, S_x, S_y, TP, FP, TN, FN);
disp(['SIR: Recall = ' num2str(recall) ', Precision = ' num2str(precision) ', f1 Score = ' num2str(f1Score) '.']);

thetaAst = Output.param;
source = Output.I_x; 
normal = Output.normal;
transformedI_x = sir_transform(source, landmarkIs, thetaAst, normal);
[rmse, mae, mee] = computeError(transformedI_x, landmarkIt);
disp(['SIR RMSE: ' num2str(rmse) '; MAE: ' num2str(mae) '; MEE: ' num2str(mee) '; runtime = ' num2str(time) '.']);
showImageRegistration(image_s, image_t, S_x, S_y, landmarkIs, landmarkIt, SirIndex);
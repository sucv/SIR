clear;
close all;

load FM_ACF;
data = 'FM_ACF';

tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));
if ismac
    directory = [pwd '/result/'];
elseif isunix
    directory = [pwd '/result/'];
elseif ispc
    directory = [pwd '\result\'];
else
    disp('Platform not supported')
end


for i=1:size(FM_ACF, 2)
    fs=FM_ACF(i).fa; ft=FM_ACF(i).fb;ds=FM_ACF(i).da; dt=FM_ACF(i).db;
    indexGroundTruth = FM_ACF(i).indexGroundTruth;
    [inlierIndex, junk] = find(indexGroundTruth);
    
    tau_0 = 1; tau = 1.3; 
    [S_x, S_y, I_0, reOrderIdx] = NNDR(fs, ft, ds, dt, tau_0, tau);  

    config.eta = 0.5;            % TPS smoothness
    config.K=5;                  % Number of nearest inliers
    config.rad=5;     			 % Bins on the radial direction
    config.tan=12;               % Bins on the tangential direction
    config.epsilon =0.001;       % Threshold for pruning
    config.lambda =1.2;          % Threshold for CALM
    config.omega = 1;			 % Strength for inter-neighborhood distance
    config.oneStep = 0;         % Whether to disable the stepwise process
    config.retrieval = 1;		 % Whether to perform the retrieval
    config.verbose=0;            % Whether to show logs
    tic;
    [Output]=sir_main(S_x, S_y, I_0, reOrderIdx, config);
    time = toc;

    SirIndex = Output.index;
    [recall, precision, f1Score, TP, FP, TN, FN] = computeMatchingRatio(inlierIndex, SirIndex, size(S_x, 1));
    FM_ACF_result(i,:) = [recall, precision, f1Score, time];
    disp(['NO.' num2str(i) ', SIR: recall = ' num2str(recall) ', precision = ' num2str(precision) ', f1-Score = ' num2str(f1Score) ', time = ' num2str(time) '.']);
end

save([directory data '_result' '.mat'], 'FM_ACF_result');
fprintf('The result has been saved to: \n');
disp([directory data '_result' '.mat']);
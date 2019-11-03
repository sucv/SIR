clear;
close all;

load IReg_RS;

for i = 1:size(IReg_RS, 2)
    
    
    fs=IReg_RS(i).fa; ft=IReg_RS(i).fb; ds=IReg_RS(i).da; dt=IReg_RS(i).db;
    lm1=IReg_RS(i).landmarkIa; lm2=IReg_RS(i).landmarkIb;

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
    config.verbose = 0;            % Whether to show logs
    tic;
    [Output]=sir_main(S_x, S_y, I_0, reOrderIdx, config);
    time = toc;
    thetaAst = Output.param;
    source = Output.controlPts; 
    normal = Output.normal;
    transformedI_x = sir_transform(source, lm1, thetaAst, normal);
    [rmse, mae, mee] = computeError(transformedI_x, lm2);
    disp(['NO.' num2str(i) '; SIR RMSE: ' num2str(rmse) '; MAE: ' num2str(mae) '; MEE: ' num2str(mee) '; runtime = ' num2str(time) '.']);
    IReg_RS_result(i, :) = [rmse mae mee time];
end
save('IReg_RS_result.mat', 'IReg_RS_result');
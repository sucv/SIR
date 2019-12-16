clear;
close all;

load IReg_FIRE;
data = 'IReg_FIRE';

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
for i = 1:size(FIRE,2) 
        fs=FIRE(i).fa; ft=FIRE(i).fb; ds=FIRE(i).da; dt=FIRE(i).db;
        lm1=FIRE(i).lm1; lm2=FIRE(i).lm2;
        
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
        FIRE_result(i, :) = [rmse mae mee time];
end

save([directory data '_result' '.mat'], 'FIRE_result');
fprintf('The result has been saved to: \n');
disp([directory data '_result' '.mat']);
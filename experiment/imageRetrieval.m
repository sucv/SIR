clear;
close all;

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


dataset = 'U1';
% dataset = 'U2';
% dataset = 'U3';
% dataset = 'U4';
% dataset = 'H1';
switch(dataset)
    case 'U1'
        load IRet_ukbench;
        queryNum=25; 
        groupSize=4;
        basis=0;
    case 'U2'
        load IRet_ukbench;
        queryNum=25; 
        groupSize=4;
        basis=100;
    case 'U3'
        load IRet_ukbench;
        queryNum=25; 
        groupSize=4;
        basis=200;
    case 'U4'
        load IRet_ukbench;
        queryNum=50; 
        groupSize=4;
        basis=0;
    case 'H1'
        load IRet_holiday;
        queryNum=25; 
        groupSize=4;
        basis=0;
end

total = basis+queryNum*groupSize-1;
n=0;

for i=basis:total
    for j = basis:total
        if j == i
            n = n + 1;
            continue;
        end
        method = 1;
        fs=ukbench(i+1).f; ds=ukbench(i+1).d; 
        ft=ukbench(j+1).f; dt=ukbench(j+1).d; 

        tau_0 = 1; tau = 1.3; 
        % Establish the universal set and putative inlier set.
        [S_x, S_y, I_0, reOrderIdx] = NNDR(fs, ft, ds, dt, tau_0, tau);  
        
        config.eta = 0.5;            % TPS smoothness
        config.K=5;                  % Number of nearest inliers
        config.rad=5;     			 % Bins on the radial direction
        config.tan=12;               % Bins on the tangential direction
        config.epsilon =0.001;       % Threshold for pruning
        config.lambda =1.6;          % Threshold for CALM
        config.omega = 1;			 % Strength for inter-neighborhood distance
        config.oneStep = 0;         % Whether to disable the stepwise process
        config.retrieval = 1;		 % Whether to perform the retrieval
        config.verbose = 0;            % Whether to show logs
        tic;
        [Output]=sir_main(S_x, S_y, I_0, reOrderIdx, config);
        time = toc;
        SirIndex = Output.index;
        
        score(i+1-basis,j+1-basis, :) = [length(SirIndex) time];

        fprintf('Progres: %.2f%%\n', (n+1)/(queryNum*groupSize)^2*100);
        n = n + 1;
    end
    save([directory dataset '_result' '.mat'], 'score','i','j','total','basis','n');
end

fprintf('The result has been saved to: \n');
disp([directory dataset '_result' '.mat']);


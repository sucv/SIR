function Output=sir_main(S_x, S_y, I_0, reOrderIdx, config)
% sir_main decides the final output according to the
%       returned status of sir .


% %%% $ INPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'S_x' and 'S_y' are the N-by-4 or N-by-2  features extracted by 
%       the loosest SIFT threshold, where the 1st and 2nd columns are 
%       the spatial coordinates, and if applicable, the 3rd and 4th columns are 
%       the scales and orientations.
% 'I_0' are the indeces of the seed points extracted by a reliable
%       SIFT threshold.
% 'reOrderIdx' stores the indeces of the reordered features, which are
%       constituted by concatenating inliers and candidates.
% 'config' stores the configuration of SIR.
%
%%%% $ OUTPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'index' is the final inlier set I*.
% 'I_x' and 'I_y' are the inliers from the two feature sets.
% 'SxHat' is the transformed moving points.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================   
    

    if size(S_x) ~= size(S_y), error('The shape of feature sets are not identical.'); end
    if ~isfield(config,'eta') || isempty(config.eta), config.eta = 0.5; end
    if ~isfield(config,'K') || isempty(config.K), config.K = 5; end
    if ~isfield(config,'rad') || isempty(config.rad), config.rad = 5; end
    if ~isfield(config,'tan') || isempty(config.tan), config.tan = 12; end
    if ~isfield(config,'epsilon') || isempty(config.epsilon), config.epsilon = 0.001; end
    if ~isfield(config,'lambda') || isempty(config.lambda), config.lambda = 1.2; end
    if ~isfield(config,'omega') || isempty(config.omega), config.omega = 1; end
    if ~isfield(config,'retrieval') || isempty(config.retrieval), config.retrieval = 1; end
    if ~isfield(config,'viz') || isempty(config.viz), config.viz = 1; end
    
    D = size(S_x, 2);
    
    % Normalization
    [nS_x, nS_y, normal]=sirNorm2(S_x,S_y, D);
    
    % Stepwise Image Registration
    [Output]=sir(nS_x, nS_y, I_0, reOrderIdx, config);
    
    % Denormalization
    transformedS_x=Output.SxHat*normal.fixScale+repmat(normal.fixMean, size(S_x, 1), 1);
    I_x = S_x(Output.IAst, 1:2); I_y = S_y(Output.IAst, 1:2);
    
    % Output
    Output.normal = normal;
    Output.SxHat = transformedS_x;
    
    if ~Output.flag
        Output.I_x = I_x; Output.I_y = I_y;
        Output.index = Output.IAst;
    else
        if ~isempty(Output.IPri)
            Output.I_x = S_x(Output.IPri, 1:2); Output.I_y = S_y(Output.IPri, 1:2);
            Output.index = Output.IPri;
        else 
            Output.I_x = []; Output.I_y = [];
            Output.index = [];
        end
    end
end


function [Output]=sir(nS_x, nS_y, I_0, reOrderIdx, config)
% sir is the core function. It returns the indeces of the preserved inliers
%       and the transformation parameter.

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
% 'IPri' is the intermediate inlier pool I' at the last iteration.
% 'IAst' is the final inlier set I*.
% 'SxHat' is the transformed moving points.
% 'param' is the transformation parameter for further image registration.
% 'flag' is to indicate whether the sir was break. Flag = 1 denotes that
%       the sir cannot find sufficient features to construct the
%       neighborhood, at which time IPri will be treated as the inlier set.
%       We find that this treatment can improve the performance on image 
%       retrieval tasks.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================   
    
    flag = 0;  % break if initial inliers are less equal than K
    D = size(nS_x, 2);
    

    % Initialization
    Y = nS_y(I_0,1:2); 
    XAndOutlier = nS_x(:,1:2); YAndOutlier = nS_y(:,1:2);
    XAndOutlierOld = XAndOutlier;
    initSeedNum =length(I_0); ptsNum = size(XAndOutlier, 1);

    % iter = -1 is for pre-alignment, 
    % iter = 0 is for re-examining the aligned seeds.
    % iter > 0 is for the stepwise process.
    % In sum, we start by pre-alignment and re-examining, 
    % followed by the stepwise process using filtered seeds.
    iter = -1; 
    inlierPool = I_0;
    verbose = config.verbose;
    K = config.K;
    XIncre = []; YIncre = []; intermidatePoolOld = 0; param = [];
    retrieval = config.retrieval;
    retrieved = 0;
    
    % If the oritention is available.
    if D == 4
        orientX = nS_x(I_0,4); orientY = nS_y(I_0,4);
    elseif D == 2 % If not, CALM will calculate it later.
        orientX = []; orientY = [];
    else
        error('The features should be N-by-2 or N-by-4.');
    end
        
    
    % Before iteration, the increment points is the initial seeds themselves.
    [intermidatePool] = computeIncreIdx(ptsNum, initSeedNum, iter, intermidatePoolOld, I_0);
    X = XAndOutlier(I_0,:); intermidatePoolOld=intermidatePool; 
    intermidatePool = reOrderIdx(intermidatePool);
    intermidatePoolOldReordered = intermidatePool;
    
    if verbose
        disp(['Raw outlier ratio = ' num2str((ptsNum - ...
            length(inlierPool)) / ptsNum * 100)  '%.' ' Starting...']);
    end

    while ~isempty(intermidatePool) 

        % Remove egregious points using pruning. For iter = -1
        % and 0, the points are the initial seeds, while they are the
        % increment points to be evaluated for the rest of the iterations.
        prunedIncreIndex = I_0;
        if iter >= 0 && size(X,1)>K
            
            [X, Y, inlierPool, prunedIncreIndex] = pruning(...
                XAndOutlier, YAndOutlier, inlierPool, ...
                intermidatePoolOldReordered, iter, config);
            
        elseif iter >= 0 && size(X,1)<=K
            flag = 1;
            break;
        end
    
        % Remove dubious points using the CALM.
        if iter ~= -1
            XIncre = XAndOutlier(prunedIncreIndex,:); 
            YIncre = YAndOutlier(prunedIncreIndex,:);
        end
        
        % CALM
        if (~isempty(XIncre) && size(X,1)>K) || iter < 0
            
            [KDistX, KDistY, distOrderX, distOrderY]=KNeighborsDistance(...
                X, Y, XIncre, YIncre, K, iter); 
            
            [histDistance, graphMatching, affinity] = shapeDist(...
                X, Y, KDistX, KDistY, distOrderX, distOrderY, ...
                XIncre, YIncre, iter, config, orientX, orientY);
            
            [X, Y, inlierPool] = calm(...
                XAndOutlier, YAndOutlier, histDistance, ...
                graphMatching, affinity, inlierPool, ...
                prunedIncreIndex, iter,config);
            
            if ~isempty(inlierPool)
                I_0Old = inlierPool;
            else
                I_0Old=[];
            end
            
            if length(inlierPool)<=K
                flag = 1;
                break;
            end
        
            
            
%         Transform the preserved seed points, with the rest points drifting
%             simultaneously.

            [XAndOutlier, param] = approximateThinPlateSpline(...
                XAndOutlierOld(inlierPool, :), Y, XAndOutlierOld, config);
    
            X = XAndOutlier(inlierPool,:);
        end
           
        if verbose
            disp(['iter = ' num2str(iter+2) ' , preserved ' ...
                num2str(length(inlierPool)) ' inliers, outlier ratio = ' ...
                num2str((ptsNum - length(inlierPool)) / ptsNum * 100) ' %.']);
        end

        % Determine the indeces of the increment points.
        if retrieved 
            break;
        end
        
        iter = iter + 1;
        [intermidatePool] = computeIncreIdx(ptsNum, initSeedNum, iter, ...
            intermidatePoolOld, inlierPool);
        
        intermidatePoolOld = intermidatePool;
        intermidatePool = reOrderIdx(intermidatePool); 
            
        if isempty(intermidatePool) && retrieval 
            intermidatePool = setdiff((1:ptsNum)', inlierPool);
            retrieved = 1;
        end
        
        intermidatePoolOldReordered = intermidatePool;
        XIncre = XAndOutlier(intermidatePool,:); 
        YIncre = YAndOutlier(intermidatePool,:);
    end
    
    Output.IPri = I_0Old;
    Output.IAst = inlierPool;
    Output.SxHat = XAndOutlier;
    Output.param = param;
    Output.flag = flag;

function [intermidatePool] = computeIncreIdx(ptsNum, initSeedNum, iter, intermidatePoolOld, inlierPool)
% computeIncreIdx returns the indeces of the upcoming
%       increment points .
%
% 'ptsNum' is the number of all the points. 
% 'initSeedNumber' is the number of the initial seed points.
% 'iter' is the current iteration number.
% 'intermidatePoolOld' is the last increase index, the last entry +1 is where
%       we start at current iteration.
% 'inlierPool' is the currently preserved inlier index.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================
    
    inlierNum = length(inlierPool);
    intermidatePoolHead = intermidatePoolOld(end)+1;
%     intermidatePoolHead = initSeedNum + 1 + (iter-1) * stepSize;
    intermidatePoolRear = intermidatePoolHead + inlierNum;

    if iter <= 0
        intermidatePoolHead = 1;
        intermidatePoolRear = initSeedNum;
    end

    if intermidatePoolRear > ptsNum
        intermidatePoolRear = ptsNum;
    end

    intermidatePool = (intermidatePoolHead : intermidatePoolRear)';
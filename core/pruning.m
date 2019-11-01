function [XPruned, YPruned, inlierPool, idxIncrePruned] = pruning(XAndOutlier, YAndOutlier, inlierPool, intermidatePoolOldReordered, iter, config)
% featureRefineByKNN removes egregious points by pruning. 
%       The distance between the corresponding inlier points after
%       transformation should be the minimum. 
%
%%%% $ INPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'XAndOutlier' and 'YAndOutlier' are the feature points extracted by the
%       loosest YIFT threshold.
% 'distOrderXtoY' are the indeces storing the i-th moving points to their
%       nearest fixed points. An entry with distOrderXtoY(i) = i is desired to 
%       preserve.
% 'inlierPool' are the preserved indeces. 
% 'intermidatePoolOldReordered' are the indeces for the increment points to be checked.
% 'iter + 1' is the iteration number.
% 'config' is the configuration of YIR.
%
%%%% $ OUTPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'XPruned' and 'YPruned' are the preserved inliers. Except for
%       the first iteration, featureRefineByKNN has no influence on them.
% 'inlierPool' are the preserved indeces. Except for
%       the first iteration, featureRefineByKNN has no influence on it.
% 'idxIncrePruned' are the preserved indeces for the increment points
%       according to the nearest neighbor criterion. They will be 
%       handed to featureRefineByYtruc for further consideration.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================  

    epsilon = config.epsilon;

    % Eliminate the points that do not satisfied the distance threshold
    % epsilon.
    idxIncrePruned = intermidatePoolOldReordered;
    XIncre = XAndOutlier(idxIncrePruned,:); YIncre = YAndOutlier(idxIncrePruned,:);
    distance = diag(computeDistance(XIncre, YIncre));
    idxIncrePruned= idxIncrePruned(distance <= epsilon);
    
    if iter ==0
        inlierPool = idxIncrePruned;
    end

    XPruned = XAndOutlier(inlierPool,:); YPruned = YAndOutlier(inlierPool,:);
function [XRefined, YRefined, inlierPool] = calm(XAndOutlier, YAndOutlier, histDistance, graphMatching, affinity, inlierPool, prunedIncreIndex, iter, config)
% Context-aware Locality Measure (CALM) removes dubious points based
%       on the neighborhood relationship, inter-neighborhood distance and
%       context information, namely graphMatching, affinity and histDistance
%       from the input. 
%       
%
%%% $ INPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'XAndOutlier' and 'YAndOutlier' are the feature points extracted by the
%       loosest SIFT threshold.
% 'histMov' and 'histFix' are the histogram matrices for the moving and
%       fixed point sets.
% 'graphMatching' is the neighborhood relationship.
% 'affinity' is the inter-neighborhood distance.
% 'histDistance' are the chi-square distance for the histogram matrices.
% 'inlierPool' are the preserved indeces for inliers.
% 'prunedIncreIndex' are the preserved indeces for the increment points,
%       which have already been checked by nearest neighbor criterion.
%
%%% $ OUTPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'XRefined' and 'YRefined' are the conbination of the preserved inliers
%       and the preserved increment points by both the nearest neighbor
%       criterion and intensity orientation criterion.
% 'inlierPool' are the preserved indeces for inliers.
%
%%=====================================================================
%% $Author: PhD Student Su XHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%===================================================================== 
    lambda = config.lambda; 
    K = config.K;
    omega = config.omega;
    
    histDistance = sum(histDistance, 2);
    cost = (graphMatching./K + omega * (1 - affinity - (iter<0))) .* (histDistance);
    idxIncreRefined = find(cost <= lambda) ;

    inlierPool = [inlierPool; prunedIncreIndex(idxIncreRefined)];
    if iter <= 0
        inlierPool = inlierPool(idxIncreRefined);
    end
    XRefined = XAndOutlier(inlierPool, :); YRefined = YAndOutlier(inlierPool, :);
function [recall, precision, f1Score, TP, FP, TN, FN] = computeMatchingRatio(groundTruth, idxByMethod, ptsNum)
%computeMatchingRatio computes the recall, precision f1-score, true
%       positive,  false positive, true negative and false negative given 
%       a index and groundTruth.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================

    tmp=zeros(1, ptsNum);
    tmp(idxByMethod) = 1;
    tmp(groundTruth) = tmp(groundTruth)+1;

    TP = find(tmp == 2);
    TP=TP';
    FP=setdiff(idxByMethod,TP);
    N=setdiff([1:ptsNum]',groundTruth);
    N2=setdiff([1:ptsNum]',idxByMethod);
    TN=intersect(N,N2);
    FN=setdiff(N2, TN);

    recall = length(TP)/(length(groundTruth) + eps);
    precision = length(TP)/(length(TP)+length(FP) + eps);
    f1Score = 2 * (recall * precision) / (recall + precision + eps);  
end
function [out1, out2, out3, out4] = KNeighborsDistance(in1, in2, in3, in4, in5, iter)
% KNeighborsDistance returns  the distance and index matrices about K
% nearest neighbors.
% 
% KDist is the distance matrix storing point-wise distances between two
%       point sets.
% distOrder is the index matrix storing the indeces in ascending order of
%       distance according to KDist.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================  
    mat1 = in1;
    mat2 = in2;
    K = in5;
   
    if iter <= 0
        [KDist1, distOrderMat1toMat1] = computeKNeighborDist(mat1', mat1', K);
        [KDist2, distOrderMat2toMat2] = computeKNeighborDist(mat2', mat2', K);     
      
    else
        mat1Incre = in3;
        mat2Incre = in4;       
        [KDist1, distOrderMat1toMat1] = computeKNeighborDist(mat1', mat1Incre', K);
        [KDist2, distOrderMat2toMat2] = computeKNeighborDist(mat2', mat2Incre', K);
    end
    
    out1 = KDist1;
    out2 = KDist2;
    out3 = distOrderMat1toMat1;
    out4 = distOrderMat2toMat2;

function [KDistance, distOrder] = computeKNeighborDist(mat1, mat2, K)
    kdTreeMat = vl_kdtreebuild(mat1);   
      
    [distOrder, KDistance] =vl_kdtreequery(kdTreeMat, mat1, mat2, 'NumNeighbors', K+1) ;
    distOrder = double(distOrder');
    KDistance = sqrt(KDistance');
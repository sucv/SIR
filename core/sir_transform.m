function grid = sir_transform(controlPts, grid, param, normal)
% sir_transform performs the ATPS transformation using the final thetaAst
%       from the SIR.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================  

    controlPtsNum = size(controlPts,1);
    gridPtsNum=size(grid,1); 
    controlPts = (controlPts - normal.movMean)/normal.movScale; 
    grid = (grid - normal.movMean)/normal.movScale; 
    
    K = repmat(grid, [1 1 controlPtsNum]) - repmat(permute(controlPts, [3 2 1]), [gridPtsNum 1 1]);
    K = max(squeeze(sum(K.^2, 2)), eps);
    K = K.* log(sqrt(K));
    P = [ones(gridPtsNum,1), grid];
    L = [K, P];
    
    grid = L * param;    
    grid=grid * normal.fixScale + normal.fixMean;
end
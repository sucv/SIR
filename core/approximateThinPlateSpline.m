function [grid, param] = approximateThinPlateSpline(X, Y, grid, config)
% approximateThinPlateSpline performs the ATPS transformation.  The
%       goal is to register the source X to the target Y, and
%       simultaneously extrapolate the coordinates for the grid. 
%
% %%% $ INPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'X' and 'Y' are the N-by-2 or N-by-3  control point sets. 
%       the loosest SIFT threshold, where the 1st and 2nd columns are 
%       the spatial coordinates, and if applicable, the 3rd and 4th columns are 
%       the scales and orientations.
% 'grid' are the object to apply ATPS transformation under the control of
%       control point sets.
% 'config' stores the configuration of SIR.
%
%%%% $ OUTPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'grid' is the transformed grid.
% 'param' is the ATPS parameter to reproduce the transformation.
%       It will be used to determined the final image transformation.
% 
% This function is inspired by G Donato and S Belongie [1].
% [1] Donato, G., & Belongie, S. (2002, May). Approximate thin 
%       plate spline mappings. In European conference on 
%       computer vision (pp. 21-31). Springer, Berlin, Heidelberg.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%===================================================================== 

    inlierNum = size(X,1);
    K = repmat(X, [1 1 inlierNum]) - repmat(permute(X, [3 2 1]), [inlierNum 1 1]);
    K = max(squeeze(sum(K.^2, 2)), eps);
    eta = config.eta;
    dim = size(X, 2) - 2;
    

    if dim
        K = sqrt(K); 
    else
        K = K.* log(sqrt(K));
    end

    P = [ones(inlierNum,1), X]; 
    L = [ [K+eta*eye(inlierNum), P];[P', zeros(3+dim,3+dim)] ]; 
    param = pinv(L) * [Y; zeros(3+dim,2+dim)]; 

    inlierAndOutlierNum=size(grid,1); 
    K = repmat(grid, [1 1 inlierNum]) - repmat(permute(X, [3 2 1]), [inlierAndOutlierNum 1 1]);
    K = max(squeeze(sum(K.^2, 2)), eps);

    if dim
        K = sqrt(K); 
    else
        K = K.* log(sqrt(K));
    end
    
    P = [ones(inlierAndOutlierNum,1), grid];
    L = [K, P];
    grid = L * param;    
end
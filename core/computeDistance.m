function [distance] = computeDistance(in1, in2, in3)
% computeDistance returns the point-wise distance for in1 and in2.
%%=====================================================================
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%===================================================================== 
    mat1 = in1;
    mat2 = in2;
    
    if nargin == 2
        n = size(mat1, 1);
        m = size(mat2, 1);
        M1=repmat(mat1, [1 1 m]);
        M2=repmat(permute(mat2, [3 2 1]), [n 1]);
        distance=squeeze(sum((M1-M2).^2,2));
        if size(M1, 1) == 1
            distance = distance';
        end
        
    elseif nargin == 3
        K = in3.K;
        mat1 = repmat(permute(mat1, [1 3 2]), [1 K 1]);
        distance = sum((mat1-mat2).^2, 3);
    end


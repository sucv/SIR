function [histDistance, graphMatching, affinity] = shapeDist(X, Y, KDistX, KDistY, distOrderX, distOrderY, XIncre, YIncre, iter, config, orientX, orientY)
% shapeDist returns the chi-square distance, neighborhood relationship
%       and inter-neighborhood distance
%
%%%% $ INPUT $%%%%%%%%%%%%%%%%%%%%%%%
% ’X‘ and 'Y' are the preserved inliers.
% 'KDist' and 'distOrder' are the distance and index matrces concerning
%       K nearest neighbors.
% 'orient' is the feature orientations. 
% 'config' is the configuration of SIR.
% 'XIncre' and 'YIncre' are the increment points to be checked.
%
%%%% $ OUTPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'histDistance' is the chi-square distance of the histograms.
% 'graphMatching' is the neighborhood relationship. 
% 'affinity' is the neighborhood distance. if iter >= 0, 
%       it is involved for regularization.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================  

    K = config.K;
    if iter > -1
        orientX = []; orientY = [];
    end
    
    if iter <= 0
        start = 2; rear = K+1;
        ptsNum = size(X, 1);
    else
        start = 1; rear = K;
        ptsNum = size(XIncre, 1);
    end
    
    graphMatching = zeros(ptsNum, 1); affinity = zeros(ptsNum, 1);
    
    
    radiusX = KDistX(:, rear);
    radiusY = KDistY(:, rear);
    distOrderXWithoutSelf = distOrderX(:, start:rear); 
    distOrderYWithoutSelf = distOrderY(:, start:rear);
    distOrderXWithoutSelf = sort(distOrderXWithoutSelf, 2);
    distOrderYWithoutSelf = sort(distOrderYWithoutSelf, 2);
     
    if iter > -1
        for i = 1: ptsNum            
                  affinity(i) = abs(corr2(X(distOrderXWithoutSelf(i,:),:), Y(distOrderYWithoutSelf(i,:),:)));
        end  
    end
    
    for i = 1: ptsNum            
              graphMatching(i) = K-sum(ismember(distOrderXWithoutSelf(i,:), distOrderYWithoutSelf(i,:)));
    end  
    
    nMovNeighbors = KNeighborsPos(X, distOrderXWithoutSelf);
    nFixNeighbors = KNeighborsPos(Y, distOrderYWithoutSelf);

    histMov = computeShapeHist(X, nMovNeighbors, radiusX, config, XIncre, orientX);
    histFix = computeShapeHist(Y, nFixNeighbors, radiusY, config, YIncre, orientY);
    histDistance = 0.5*(histMov-histFix).^2 ./ (histMov+histFix+eps);
        
function [histogram] = computeShapeHist(in1, in2, in3, in4, in5, in6)
% computeShapeHist returns the histogram matrix for a point set. The
%       scales and orientations are different and specified for each point.
%       This function is inspired by Serge Belongie et al. [1].

% REFERENCE:
% [1] Belongie, Serge, Jitendra Malik, and Jan Puzicha. 
%       "Shape matching and object recognition using shape contexts." 
%       IEEE transactions on PAMI 24, no. 4 (2002): 509-522.
%
%%=====================================================================
%% $Author: PhD Student Su XHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================  

    if isempty(in5)
        pts = in1;
    else    
        pts = in5;
    end
    
    ptsNeighbors = in2;
    scale = in3;
    ptsNum = size(pts, 1);
    histScale = scale; 
    radInner = 1/8;
    radOuter = 2;
    config = in4;
    K = config.K;
    binThetaNum = config.tan;
    binRadialNum = config.rad;
    
    pts2KNeighbors = sqrt(computeDistance(pts, ptsNeighbors, config));
    pts3D =repmat(permute(pts, [1 3 2]), [1 K 1]);
    
    if isempty(in6) 
            centroid = squeeze(mean(ptsNeighbors(:,1,:),2));
            histOrient = atan2(pts(:,2)-centroid(:,2), pts(:,1)-centroid(:,1));
        else
            histOrient = in6;
    end
    
    thetaArray = atan2(ptsNeighbors(:,:,2)-pts3D(:,:,2), ptsNeighbors(:,:,1)-pts3D(:,:,1));
    thetaArray = thetaArray-histOrient;

    binEdges = logspace(log10(radInner),log10(radOuter),binRadialNum);
    binEdges = repmat(binEdges, [ptsNum, 1]);
    binScaleRatio = histScale ./ binEdges(:, binRadialNum);
    binEdges = binEdges .* binScaleRatio +eps;
    binRadialAssign = zeros(ptsNum, K);
    for i = 1:binRadialNum
        binRadialAssign = binRadialAssign + (pts2KNeighbors <= binEdges(:, i));
    end

    thetaArray = rem(rem(thetaArray,2*pi)+2*pi,2*pi);
    binThetaAssign = 1+floor(thetaArray/(2*pi/binThetaNum));

    binNum = binThetaNum * binRadialNum; 
    histogram = zeros (ptsNum, binNum); 

    for i = 1:ptsNum
        histPerPts =sparse(binThetaAssign(i,:),binRadialAssign(i,:),1,binThetaNum,binRadialNum);
        histogram(i,:) = histPerPts(:)';
    end
        

function [nNeighbors] = KNeighborsPos(pts, distOrder)
% KNeighborsPos returns the coordinates of the nieghbors 
% according to the index matrix distOrder for a point set pts.
%
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================  

    nDim1 = pts(:,1);nDim2 = pts(:,2);
    nNeighborsDim1 = nDim1(distOrder);  
    nNeighborsDim2 = nDim2(distOrder);
    nNeighbors = cat(3, nNeighborsDim1, nNeighborsDim2);

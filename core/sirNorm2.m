function [nS_x, nS_y, normal]=sirNorm2(S_x, S_y, D)
% sirNorm2 normalizes the feature point sets to have zero mean and unit
%       standard variation.
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================   

    M = size(S_x, 1); N = size(S_y, 1);
    
    nS_x=S_x;
    nS_y=S_y;

    movPts = S_x(:,1:2); 
    fixPts = S_y(:,1:2); 
    normal.movMean=mean(movPts); normal.fixMean=mean(fixPts);
    
    movPts=movPts-repmat(normal.movMean,M,1);
    fixPts=fixPts-repmat(normal.fixMean,N,1);
    normal.movScale=sqrt(sum(sum(movPts.^2,2))/M);
    normal.fixScale=sqrt(sum(sum(fixPts.^2,2))/N);
    
    movPts=movPts/normal.movScale;
    fixPts=fixPts/normal.fixScale;
    nS_x(:,1:2)=movPts;
    nS_y(:,1:2)=fixPts;
    
    if D == 4
            nS_x(:,3)=nS_x(:,3)./normal.movScale;
            nS_y(:,3)=nS_y(:,3)./normal.fixScale;
    end
        
end
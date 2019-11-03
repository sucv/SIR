function [S_x, S_y,  seedPtsIdx, reOrderIdx] = NNDR(fs, ft, ds, dt, tau_0, tau)
% siftMatch returns the two feature locs 'S_x' and 'S_y' with the
%       loosest SIFT threshold, and the indeces 'seedPtsIdx' for the initial seed points.
%
% %%% $ INPUT $%%%%%%%%%%%%%%%%%%%%%%%
% 'fs' and 'ft' are the 4-by-N and 4-by-M  features extracted by 
%       the loosest SIFT threshold, where the 1st and 2nd rows are 
%       the spatial coordinates, and the 3rd and 4th rows are 
%       the scales and orientations.
% 'ds' and 'dt' are the 128-by-N and 128-by-M  feature descriptor corresponding
%       to fs and ft, respectively, where each column is the 128 
%       dimensional SIFT feature descriptor for a feature point.
% 'I_0' are the indeces of the seed points extracted by a reliable
%       SIFT threshold.
% 'tau_0' is the loosest NNDR threshold used to establish the universal
%       feature set.
% 'tau' is the NNDR threshold to establish the putative inlier set for the
%       SIR.

%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================
    
    % Error prevention
    if ~exist('vl_ubcmatch')
        error('MyComponent:incorrectType',...
            'vl_ubcmatch function is not defined. \nPlease run vl_setup.m from your VLFEAT toolbox to load vl_ubcmatch function. \nIt can be downloaded from http://www.vlfeat.org/download.html. \nPlease follow http://www.vlfeat.org/install-matlab.html for either one-time or permanent setup.');
    end
    
    [matchesLoose, ~] = vl_ubcmatch(ds, dt,tau_0) ;
    [matches, ~] = vl_ubcmatch(ds, dt,tau) ;
    matchesRemain=(setdiff(matchesLoose',matches','rows'))';
    [~, seedPtsIdx] = ismember(matches', matchesLoose', 'rows');
    [~, remainPtsIdx] = ismember(matchesRemain', matchesLoose', 'rows');
    reOrderIdx = [seedPtsIdx; remainPtsIdx];

    S_x=fs(:,matchesLoose(1,:))';
    S_y=ft(:,matchesLoose(2,:))';
end



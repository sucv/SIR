function [rmse, mae, mee] = computeError(lmIsTrans, landmarkIt)
%computeError computes the root square mean error (RMSE)
%       maximum error (MAE) and median error (MEE). Givn N
%       pairs of landmarks,The MAE and MEE are the maximum
%       and median errors from the N pairs of landmarks.
%%=====================================================================
%% $Author: PhD Student Su ZHANG$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================
    rmse = sqrt(immse(lmIsTrans, landmarkIt));
    mae = max(sqrt(sum((lmIsTrans-landmarkIt).^2, 2)));
    mee = median(sqrt(sum((lmIsTrans-landmarkIt).^2, 2)));
end


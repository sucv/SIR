function [rmse, mae, mee] = computeError(lmIsTrans, landmarkIt)
%computeError computes the root square mean error (RMSE)
%       maximum error (MAE) and median error (MEE). Givn N
%       pairs of landmarks,The MAE and MEE are the maximum
%       and median errors from the N pairs of landmarks.

    rmse = sqrt(immse(lmIsTrans, landmarkIt));
    mae = max(sqrt(sum((lmIsTrans-landmarkIt).^2, 2)));
    mee = median(sqrt(sum((lmIsTrans-landmarkIt).^2, 2)));
end


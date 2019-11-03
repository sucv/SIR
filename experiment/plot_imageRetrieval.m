close all;
clear;

load U3_result;


if n == 10000
    queriesNum = 25;
elseif n == 40000
    queriesNum = 50;
else
    error('The result is not correct. Maybe the retrieval has yet completed.')
end



groupSize = 4;
s = score(:,:,1);
lines = queriesNum * groupSize;
[~, selectedImg] = maxk(s', 3, 2);
result = zeros(size(selectedImg));
truthList = [1, 2, 3, 4];
ith = 1;
for query = 1:queriesNum
    for classNum = 1:groupSize
        truth = setdiff(truthList + (query-1) * 4, ith);
        result(ith, :) = ismember(truth, selectedImg(ith, :));
        ith = ith + 1;
    end
end
nscore = sum(result(:))/lines;
time = sum(sum(score(:,:,2)'));
fprintf('The nscore is %.2f, and time cost is %.2f\n', nscore, time);



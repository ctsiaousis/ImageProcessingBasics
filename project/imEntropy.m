function [ en ] = imEntropy( I )
    [cnt,binsX] = imhist(I);
    % remove zero entries that would cause log2 to return NaN
    cnt(cnt==0) = [];
    % normalize histogram to unity
    cnt = cnt/numel(I);
    % calculate entropy
    en = -sum(cnt.*log2(cnt));
end


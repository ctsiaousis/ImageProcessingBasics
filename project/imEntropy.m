function [ en ] = imEntropy( I )
    I = uint8(I); %8-bits per pixel [0,255]
    [cnt,binsX] = imhist(I);
    % remove zero entries that would cause log2 to return NaN
    cnt(cnt==0) = [];
    % normalize histogram to propabilities
    cnt = cnt/numel(I);
    % calculate entropy
    en = -sum(cnt.*log2(cnt));
end


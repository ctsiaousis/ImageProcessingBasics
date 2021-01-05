function en = imEntropy( I )
    % 8-bits per pixel [0,255]
    I = uint8(I);
    % get image's histogram
    [cnt,binsX] = imhist(I);
    % remove zero entries that would cause NaN
    cnt(cnt==0) = [];
    % normalize histogram to propabilities
    cnt = cnt/numel(I);
    % calculate entropy
    en = -sum(cnt.*log2(cnt));
end


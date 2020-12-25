function Arec = synthesis (Ahaar , level)
    assert(level<=log2(length(Ahaar)),'Level too big for this input.');
    assert((-1)^(length(Ahaar))==1,'Length of input signal must be even');

    Arec = Ahaar; % for multilevel calculations
    for decomp=level:-1:1 
        Alevel=Arec(1:(end/2)/2^(decomp-1)) %means of level
        %% 2.b
        Au = Alevel; %upsampling the means of the specific level
        Aupc = repmat(Au(:)',2,1); %repeating each value 2 times
        Aupc = Aupc(:); %making the 2-d array, 1 column
        Aup = Aupc.'; %making the column 1 line
        %% 2.c
        dif = Arec(length(Alevel)+1:end); % take all remaining diffs
        q=1; % 2^(decomp-1);
        for n=1:2:length(Aup)-1
            Arec(n) = Aup(n) + dif(q);
            Arec(n+1) = Aup(n+1) - dif(q);
            q = q + 1;
        end
        clear dif; %clear local variables
        clear Aup; %to have the right lengths
        clear Au; %for the next itteration
        clear Alevel;
    end
end
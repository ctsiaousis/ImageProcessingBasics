function Ahaar = haar1analysis (A, level)
    assert(level<=log2(length(A)),'Level too big for this input.');
    assert((-1)^(length(A))==1,'Length of input signal must be even');

    for decomp=1:level
        assert((-1)^(length(A))==1,'Level length not even. Change value');
        %% 1.b
        k=1;
        for i=1:2:(length(A)-1)
            Ag{k} = A(:,i:i+1); %make tuples
            k=k+1;
        end
        %% 1.c
        for j=1:(length(A)/2) % length(Ag) doesn't work for multi-level
           Am(j) = mean(Ag{j}); %calculate means
        end

        %% 1.d
        p=1;
        for x=1:2:(length(A)-1)
            Ad(p) = A(x) - Am(p); %calculate diffs
            p = p + 1;
        end
        %% 1.e
        Ahaar(1:(length(A)/2)) = Am; %first half is means
        Ahaar((length(A)/2)+1:length(A)) = Ad; %second is diferences
        A = Am; % next level computed by mean values
        clear Ad; %clear local variables
        clear Am; %to have the right lengths
        clear Ag; %for the next itteration
    end
end
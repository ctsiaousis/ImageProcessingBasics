function entrOfSubBands( imHarAnal )
    [r,c] = size(imHarAnal);

    enH7 = imEntropy( imHarAnal(1:r/4  , 1:c/4) );
    enH6 = imEntropy( imHarAnal(r/4:r/2, 1:c/4) );
    enH5 = imEntropy( imHarAnal(r/4:r/2, c/4:c/2) );
    enH4 = imEntropy( imHarAnal(1:r/4  , c/4:c/2) );
    enH3 = imEntropy( imHarAnal(r/2:r  , 1:c/2) );
    enH2 = imEntropy( imHarAnal(r/2:r  , c/2:c) );
    enH1 = imEntropy( imHarAnal(1:r/2  , c/2:c) );
    enH0 = imEntropy( imHarAnal );
    fprintf('ENTROPY--H7 :\t%d\n',enH7);
    fprintf('ENTROPY--H6 :\t%d\n',enH6);
    fprintf('ENTROPY--H5 :\t%d\n',enH5);
    fprintf('ENTROPY--H4 :\t%d\n',enH4);
    fprintf('ENTROPY--H3 :\t%d\n',enH3);
    fprintf('ENTROPY--H2 :\t%d\n',enH2);
    fprintf('ENTROPY--H1 :\t%d\n',enH1);
    fprintf('ENTROPY--H0 :\t%d\t(whole Image)\n',enH0);
end


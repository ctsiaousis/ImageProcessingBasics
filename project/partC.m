function partC( inIm )
    fprintf('--------------PART C--------------\n');
    inIm = imresize(inIm,[256 256]);

    %easier to work with doubles (still display as uint8)
    inIm  =double(inIm);
    imOrig=double(inIm);

    %% 2 level Haar-2D-wavelet transformation
    imHarAnal = haar2anal( inIm, 2);

    figure
    subplot(1,2,1);
    imagesc(imHarAnal); colormap gray; colorbar;
    title('The analized Image');
    footNote = ['Note that the negative values are at most -50.' ...
        ' We later utilize that only the subbands of' ...
        ' differences have negative values.'];
    xlabel(footNote);
    inIm = haar2syn( imHarAnal, 2);
    subplot(1,2,2);
    imshow(uint8(cat(2, inIm, imOrig)));
    title('left: Synthesis of HAAR, right: Original');
    xlabel('note: synthesis before quantization of subbands')

    %% For error checking, assert that decomp and comp is fine with HAAR
    errAssrt = immse(inIm,imOrig);
    assert(errAssrt == 0,'Haar anal and synth doesnt work as expected');
    
    %% Backup the analized image for second round of Quantization
    haarAnalBckup = imHarAnal;
    
    
    fprintf('\n\t--First Method--\n\n');
    %% Quantize all subbands but the image (H7)
    [r,c] = size(imHarAnal);
    l = 2^4; % quantize with r=4 both levels
    
    %since we quantize the differences in haar, our quantization window
    %must be at least [ -|min(A)|, |min(A)| ]
    A = ceil( abs( min( min(imHarAnal))));
    
    %H6
    imHarAnal(r/4:r/2, 1:c/4)  = uni_scalar(imHarAnal(r/4:r/2, 1:c/4)  ,A,l);
    %H5
    imHarAnal(r/4:r/2, c/4:c/2)= uni_scalar(imHarAnal(r/4:r/2, c/4:c/2),A,l);
    %H4
    imHarAnal(1:r/4  , c/4:c/2)= uni_scalar(imHarAnal(1:r/4  , c/4:c/2),A,l);
    %H3
    imHarAnal(r/2:r  , 1:c/2)  = uni_scalar(imHarAnal(r/2:r  , 1:c/2)  ,A,l);
    %H2
    imHarAnal(r/2:r  , c/2:c)  = uni_scalar(imHarAnal(r/2:r  , c/2:c)  ,A,l);
    %H1
    imHarAnal(1:r/2  , c/2:c)  = uni_scalar(imHarAnal(1:r/2  , c/2:c)  ,A,l);
    
    %% Entropy
    entrOfSubBands( imHarAnal );

    %% Display reConstruction
    figure;
    inIm = haar2syn( imHarAnal, 2);
    imshow(uint8(inIm));
    peakSNR = psnr(inIm,imOrig);
    str = sprintf('First Method Image has %0.2f dB peak-SNR', peakSNR);
    t = title(str);
    % compression Ratio
    originalEntropy = imEntropy(imOrig);
    compressEntropy = imEntropy(imHarAnal);
    ratio = originalEntropy/compressEntropy;
    fprintf('First Method: Total compression ratio is: %0.2f\n',ratio);
    
    
    fprintf('\n\t--Second Method--\n\n');
    %% Quantize first layer (H1, H2, H3) with r=3
    imHarAnal = haarAnalBckup;
    [r,c] = size(imHarAnal);
    l = 2^3; % r=3 for first level
    A = ceil( abs( min( min(imHarAnal))));
    %H3
    imHarAnal(r/2:r  , 1:c/2)  = uni_scalar(imHarAnal(r/2:r  , 1:c/2)  ,A,l);
    %H2
    imHarAnal(r/2:r  , c/2:c)  = uni_scalar(imHarAnal(r/2:r  , c/2:c)  ,A,l);
    %H1
    imHarAnal(1:r/2  , c/2:c)  = uni_scalar(imHarAnal(1:r/2  , c/2:c)  ,A,l);
    
    %% Quantize second layer (H4, H5, H6) with r=5
    l = 2^5; % r=5 for second level
    %H6
    imHarAnal(r/4:r/2, 1:c/4)  = uni_scalar(imHarAnal(r/4:r/2, 1:c/4)  ,A,l);
    %H5
    imHarAnal(r/4:r/2, c/4:c/2)= uni_scalar(imHarAnal(r/4:r/2, c/4:c/2),A,l);
    %H4
    imHarAnal(1:r/4  , c/4:c/2)= uni_scalar(imHarAnal(1:r/4  , c/4:c/2),A,l);
    
    %% Entropy
    entrOfSubBands( imHarAnal );

    %% Display reConstruction
    figure;
    inIm = haar2syn( imHarAnal, 2);
    imshow(uint8(inIm));
    peakSNR = psnr(inIm,imOrig);
    str = sprintf('Second Method Image has %0.2f dB peak-SNR', peakSNR);
    t = title(str);
    % compression Ratio
    originalEntropy = imEntropy(imOrig);
    compressEntropy = imEntropy(imHarAnal);
    ratio = originalEntropy/compressEntropy;
    fprintf('Second Method: Total compression ratio is: %0.2f\n',ratio);
    
    fprintf('----------------------------------\n');
end


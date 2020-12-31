clc;
clear all;
close all;

%% Design our 1-D input signal
% and plot a sample quantized signal
A=255;
t = (-1.5*A:1.5*A)';
inS = (abs(t)<=A).*t;
% tf = uni_scalar(inS,A,4);
% figure
% plot(inS,tf,'r');
% grid on
% hold on
% plot(inS,'g');


%% Plot 9 levels of quantization
%keep in mind that desiredL = 2^R
figure
levels=9;
for r=0:levels-1
    newQ=uni_scalar(inS,A/2,2^r);
    subplot(2,5,r+1)
    plot(t,newQ)
    str = sprintf('CharFunc of uni_scalar, r=%d', r);
    title(str)
    grid on
end


%% Quantize `lena_gray_512.tif`
figure
lena=imread('lena_gray_512.tif');

levels=9;
errors=zeros(levels,1);
for r=0:levels-1
    l = 2^r;
    q=uni_scalar(lena,A/2,l);
    errors(r+1)=immse(lena,q);
    fprintf('MSE--level-%d :\t%d\n',r, errors(r+1));
    
    %illustrate the results
    subplot(2,5,r+1)
    imagesc(q)
    colormap gray; colorbar
    grid on
end

% plot mserrors
figure;
semilogy([0:8],errors)
grid on


%% Part B
% vidX=VideoReader('xylophone3.mp4');



%% Part C
inIm = imread('frame50.png');
inIm = rgb2gray(inIm);
inIm = imresize(inIm,[256 256]);

%easier to work with doubles (still display as uint8)
inIm  =double(inIm);
imOrig=double(inIm);

% inIm = magic(16);
% imOrig = inIm;
imHarAnal = haar2anal( inIm, 2);

figure
subplot(1,2,1);
imshow(uint8(imHarAnal));

inIm = haar2syn( imHarAnal, 2);
subplot(1,2,2);
imshow(uint8(cat(2, inIm, imOrig)));


fprintf('MSE--HAAR :\t%d\n',immse(inIm,imOrig));

%% Entropy
[r,c] = size(imHarAnal);

enH7 = imEntropy( imHarAnal(1:r/4  , 1:c/4) );
enH6 = imEntropy( imHarAnal(r/4:r/2, 1:c/4) );
enH5 = imEntropy( imHarAnal(r/4:r/2, c/4:c/2) );
enH4 = imEntropy( imHarAnal(1:r/4  , c/4:c/2) );
enH3 = imEntropy( imHarAnal(r/2:r  , 1:c/2) );
enH2 = imEntropy( imHarAnal(r/2:r  , c/2:c) );
enH1 = imEntropy( imHarAnal(1:r/2  , c/2:c) );


enH0 = imEntropy( imHarAnal );
enOr = imEntropy( imOrig );


fprintf('ENTROPY--H7 :\t%d\n',enH7);
fprintf('ENTROPY--H6 :\t%d\n',enH6);
fprintf('ENTROPY--H5 :\t%d\n',enH5);
fprintf('ENTROPY--H4 :\t%d\n',enH4);
fprintf('ENTROPY--H3 :\t%d\n',enH3);
fprintf('ENTROPY--H2 :\t%d\n',enH2);
fprintf('ENTROPY--H1 :\t%d\n',enH1);
fprintf('ENTROPY--H0 :\t%d\n',enH0);
fprintf('ENTROPY--ORIG :\t%d\n',enOr);

return;

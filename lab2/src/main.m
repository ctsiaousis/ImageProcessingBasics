clear all;
close all;

I = imread('lena.tif');
F = [1 2 1; 2 4 2; 1 2 1];
F = F/16;

zerosI = padForConv(double(I),double(F),'zero');

fillI = padForConv(double(I),double(F),'fill');

message = sprintf('← Original Image.\n↙ zero padding.\n↓ replicate padding');
%---------------------------------------------------
outZ = convolution(zerosI, double(F));
outF = convolution(fillI, double(F));
outZ = uint8(outZ);
outF = uint8(outF);


figure;
subplot(2,2,1);imshow(I)
subplot(2,2,2);
title('Our implementation', 'FontSize', 14, 'Color', 'b', 'FontWeight', 'bold');
text(0.2,0.5,message, 'FontSize', 12); axis off
subplot(2,2,3);imshow(outZ)
subplot(2,2,4);imshow(outF)

mseMineZero = immse(outZ, I);
mseMineFill = immse(outF, I);
psnrMineZero = psnr(outZ, I);
psnrMineFill = psnr(outF, I);

%---------------------------------------------------
convZ = conv2(zerosI, double(F), 'valid');
convF = conv2(fillI, double(F), 'valid');
convZ = uint8(convZ);
convF = uint8(convF);

figure;
subplot(2,2,1);imshow(I)
subplot(2,2,2);
title('conv2() Function', 'FontSize', 14, 'Color', 'b', 'FontWeight', 'bold');
text(0.2,0.5,message, 'FontSize', 12); axis off
subplot(2,2,3);imshow(convZ)
subplot(2,2,4);imshow(convF)

mseConvZero = immse(convZ, I);
mseConvFill = immse(convF, I);
psnrConvZero = psnr(convZ, I);
psnrConvFill = psnr(convF, I);

%---------------------------------------------------
imfilterZ = imfilter(double(I), double(F), 0, 'conv');
imfilterF = imfilter(double(I), double(F), 'replicate', 'conv');

imfilterZ = uint8(imfilterZ);
imfilterF = uint8(imfilterF);

figure;
subplot(2,2,1);imshow(I)
subplot(2,2,2);
title('imfilter() Function', 'FontSize', 14, 'Color', 'b', 'FontWeight', 'bold');
text(0.2,0.5,message, 'FontSize', 12); axis off
subplot(2,2,3);imshow(imfilterZ)
subplot(2,2,4);imshow(imfilterF)

mseImfilterZero = immse(imfilterZ, I);
mseImfilterFill = immse(imfilterF, I);
psnrImfilterZero = psnr(imfilterZ, I);
psnrImfilterFill = psnr(imfilterF, I);

%--------------------------------------------------
fprintf('Now lets check the errors!\n')

fprintf('----Our implementation.----\n--Zero padding: \n')
fprintf('MSE: %0.2f\tPSNR: %0.2f\n',mseMineZero, psnrMineZero)
fprintf('--Replicate padding:\nMSE: %0.2f\tPSNR: %0.2f\n',mseMineFill, psnrMineFill)

fprintf('----conv2() function.----\n--Zero padding: \n')
fprintf('MSE: %0.2f\tPSNR: %0.2f\n',mseConvZero, psnrConvZero)
fprintf('--Replicate padding:\nMSE: %0.2f\tPSNR: %0.2f\n',mseConvFill, psnrConvFill)

fprintf('----imfilter() function.----\n--Zero padding: \n')
fprintf('MSE: %0.2f\tPSNR: %0.2f\n',mseImfilterZero, psnrImfilterZero)
fprintf('--Replicate padding:\nMSE: %0.2f\tPSNR: %0.2f\n',mseImfilterFill, psnrImfilterFill)

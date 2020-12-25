clear all;
close all;

I = imread('peppers_gray.tif');

message = sprintf('Result after convolution with differential filter F');
original=sprintf('<= Original Image (peppers gray)');

F = [-1 0 1];
F1=[0 1 0; 1 0 1; 0 -1 0];
helper = ones(3,3);
I=I(:,:,1);
zerosM = padForConv(double(I),double(helper),'zero');
outZ = convolution_bonus(zerosM, double(F));

figure; 
subplot(2,1,1);imshow(I);
title('Our implementation for the bonus exercise', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [330 -25 0]);
text(530,280,original, 'FontSize', 10);
text(-270,630,message, 'FontSize', 12);
subplot(2,1,2);imagesc(outZ);
colorbar


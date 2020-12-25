clear all;
close all;

I = imread('noisyimg.png');
I1= imread('noisyimg2.png');
g= ones(3,3);
g1=ones(5,5);
g2=ones(9,9);
%-- 3x3
message = sprintf('<=Original Images | Zero paddings=>');

zerosM = padForConv(double(I),double(g),'zero');
outZ = Compute_Median(zerosM, double(g));

zerosM1 = padForConv(double(I1),double(g),'zero');
outZ1 = Compute_Median(zerosM1, double(g));

figure;
subplot(2,2,1); imshow(I);
subplot(2,2,2); imagesc(outZ);
title('Our implementation of 3x3 median filter', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [-70 -25 0]);
text(-450,630,message, 'FontSize', 12);
subplot(2,2,3); imshow(I1);
subplot(2,2,4); imagesc(outZ1);

%-- 5x5

zerosM2 = padForConv(double(I),double(g1),'zero');
outZ2 = Compute_Median(zerosM2, double(g1));

zerosM3 = padForConv(double(I1),double(g1),'zero');
outZ3 = Compute_Median(zerosM3, double(g1));

figure;
subplot(2,2,1); imshow(I);
subplot(2,2,2); imagesc(outZ2);
title('Our implementation of 5x5 median filter', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [-70 -25 0]);
text(-450,630,message, 'FontSize', 12);
subplot(2,2,3); imshow(I1);
subplot(2,2,4); imagesc(outZ3);

%-- 9x9

zerosM4 = padForConv(double(I),double(g2),'zero');
outZ4 = Compute_Median(zerosM4, double(g2));

zerosM5 = padForConv(double(I1),double(g2),'zero');
outZ5 = Compute_Median(zerosM5, double(g2));

figure;
subplot(2,2,1); imshow(I);
subplot(2,2,2); imagesc(outZ4);
title('Our implementation of 9x9 median filter', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [-70 -25 0]);
text(-450,630,message, 'FontSize', 12);
subplot(2,2,3); imshow(I1);
subplot(2,2,4); imagesc(outZ5);

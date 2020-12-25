clear all;
close all;

I = imread('noisyimg.png');
I1= imread('noisyimg2.png');
g= ones(3,3);
g1=ones(5,5);
g2=ones(9,9);
%% -- 3x3
message = sprintf('Result for minimum computation | Result for maximum computation');
original=sprintf('<= Original Image');

zerosM = padForConv(double(I),double(g),'zero');
outZ = Compute_Min(zerosM, double(g));
outZm = Compute_Max(zerosM, double(g));

figure;
subplot(2,2,1); imshow(I);
title('Our implementation of 3x3 filter for the first image', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [730 -25 0]);
text(700,280,original, 'FontSize', 14);
text(-200,630,message, 'FontSize', 12);
subplot(2,2,3); imagesc(outZ);colorbar
subplot(2,2,4); imagesc(outZm);colorbar



zerosM1 = padForConv(double(I1),double(g),'zero');
outZ1 = Compute_Min(zerosM1, double(g));
outZ1m = Compute_Max(zerosM1, double(g));

figure;
subplot(2,2,1); imshow(I1);
title('Our implementation of 3x3 filter for the second image', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [730 -25 0]);
text(700,280,original, 'FontSize', 14);
text(-200,630,message, 'FontSize', 12);
subplot(2,2,3); imagesc(outZ1);colorbar
subplot(2,2,4); imagesc(outZ1m);colorbar

%-- 5x5

zerosM2 = padForConv(double(I),double(g1),'zero');
outZ2 = Compute_Min(zerosM2, double(g1));
outZ2m = Compute_Max(zerosM2, double(g1));

figure;
subplot(2,2,1); imshow(I);
title('Our implementation of 5x5 filter for the first image', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [730 -25 0]);
text(700,280,original, 'FontSize', 14);
text(-200,630,message, 'FontSize', 12);
subplot(2,2,3); imagesc(outZ2);
colorbar
subplot(2,2,4); imagesc(outZ2m);
colorbar


zerosM3 = padForConv(double(I1),double(g1),'zero');
outZ3 = Compute_Min(zerosM3, double(g1));
outZ3m = Compute_Max(zerosM3, double(g1));

figure;
subplot(2,2,1); imshow(I1);
title('Our implementation of 5x5 filter for the second image', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [730 -25 0]);
text(700,280,original, 'FontSize', 14);
text(-200,630,message, 'FontSize', 12);
subplot(2,2,3); imagesc(outZ3);
colorbar
subplot(2,2,4); imagesc(outZ3m);
colorbar


%% -------------------- 9x9 ----------------

zerosM4 = padForConv(double(I),double(g2),'zero');
outZ4 = Compute_Min(zerosM4, double(g2));
outZ4m = Compute_Max(zerosM4, double(g2));

figure;
subplot(2,2,1); imshow(I);
title('Our implementation of 9x9 filter for the first image', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [730 -25 0]);
text(700,280,original, 'FontSize', 14);
text(-200,630,message, 'FontSize', 12);
subplot(2,2,3); imagesc(outZ4);
colorbar
subplot(2,2,4); imagesc(outZ4m);
colorbar

zerosM5 = padForConv(double(I1),double(g2),'zero');
outZ5 = Compute_Min(zerosM5, double(g2));
outZ5m = Compute_Max(zerosM5, double(g2));

% ------------------ image1
figure;
subplot(2,2,1); imshow(I1);
title('Our implementation of 9x9 filter for the second image', 'FontSize', 15, 'Color', 'b', 'FontWeight', 'bold','Position', [730 -25 0]);
text(700,280,original, 'FontSize', 14);
text(-200,630,message, 'FontSize', 12);
colormap gray
subplot(2,2,3); imagesc(outZ5);
colorbar
subplot(2,2,4); imagesc(outZ5m);
colorbar


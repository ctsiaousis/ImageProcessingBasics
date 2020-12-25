clear all;
close all;
I = imread('gray.tif');
original = I(:,:,1);

%% Downscale
bilinearFactor2 = imresize(original, 1/2, 'bilinear','Antialiasing',false);
bilinearFactor4 = imresize(original, 1/4, 'bilinear','Antialiasing',false);
bilinearFactor8 = imresize(original, 1/8, 'bilinear','Antialiasing',false);
nearestFactor2 = imresize(original, 1/2, 'nearest','Antialiasing',false);
nearestFactor4 = imresize(original, 1/4, 'nearest','Antialiasing',false);
nearestFactor8 = imresize(original, 1/8, 'nearest','Antialiasing',false);
bicubicFactor2 = imresize(original, 1/2, 'bicubic','Antialiasing',false);
bicubicFactor4 = imresize(original, 1/4, 'bicubic','Antialiasing',false);
bicubicFactor8 = imresize(original, 1/8, 'bicubic','Antialiasing',false);


%% Upscale
newBL2 = imresize(bilinearFactor2, 2, 'bilinear','Antialiasing',false);
newBL4 = imresize(bilinearFactor4, 4, 'bilinear','Antialiasing',false);
newBL8 = imresize(bilinearFactor8, 8, 'bilinear','Antialiasing',false);
newNN2 = imresize(nearestFactor2, 2, 'nearest','Antialiasing',false);
newNN4 = imresize(nearestFactor4, 4, 'nearest','Antialiasing',false);
newNN8 = imresize(nearestFactor8, 8, 'nearest','Antialiasing',false);
newBC2 = imresize(bicubicFactor2, 2, 'bicubic','Antialiasing',false);
newBC4 = imresize(bicubicFactor4, 4, 'bicubic','Antialiasing',false);
newBC8 = imresize(bicubicFactor8, 8, 'bicubic','Antialiasing',false);

%% Plot downscales w/out Antialiasing
figure(1)
subplot(4,3,2), imshow(original); title('original image');
subplot(4,3,4), imshow(nearestFactor2);
title('nearest-neighbor (1/2 without A-A)');
subplot(4,3,5), imshow(nearestFactor4);
title('nearest-neighbor (1/4 without A-A)');
subplot(4,3,6), imshow(nearestFactor8);
title('nearest-neighbor (1/8 without A-A)');
subplot(4,3,7), imshow(bilinearFactor2);
title('bilinear (1/2 without A-A)');
subplot(4,3,8), imshow(bilinearFactor4);
title('bilinear (1/4 without A-A)');
subplot(4,3,9), imshow(bilinearFactor8);
title('bilinear (1/8 without A-A)');
subplot(4,3,10), imshow(bicubicFactor2);
title('bicubic (1/2 without A-A)');
subplot(4,3,11), imshow(bicubicFactor4);
title('bicubic (1/4 without A-A)');
subplot(4,3,12), imshow(bicubicFactor8);
title('bicubic (1/8 without A-A)');

%% print the MSE compared to original
errBL2 = immse(newBL2, original);
nbl2 = sprintf('\n bilinear (1/2 without A-A), MSE: %0.1f\n', errBL2);
errBL4 = immse(newBL4, original);
nbl4 = sprintf('\n bilinear (1/4 without A-A), MSE: %0.1f\n', errBL4);
errBL8 = immse(newBL8, original);
nbl8 = sprintf('\n bilinear (1/8 without A-A), MSE: %0.1f\n', errBL8);

errNN2 = immse(newNN2, original);
nnn2 = sprintf('nearest-neighbor(1/2 without A-A),MSE: %0.1f\n',errNN2);
errNN4 = immse(newNN4, original);
nnn4 = sprintf('nearest-neighbor(1/4 without A-A),MSE: %0.1f\n',errNN4);
errNN8 = immse(newNN8, original);
nnn8 = sprintf('nearest-neighbor(1/8 without A-A),MSE: %0.1f\n',errNN8);

errBC2 = immse(newBC2, original);
nbc2 = sprintf('\n bicubic (1/2 without A-A), MSE: %0.1f\n', errBC2);
errBC4 = immse(newBC4, original);
nbc4 = sprintf('\n bicubic (1/4 without A-A), MSE: %0.1f\n', errBC4);
errBC8 = immse(newBC8, original);
nbc8 = sprintf('\n bicubic (1/8 without A-A), MSE: %0.1f\n', errBC8);

%% Plot upscaled
figure(2)
subplot(3,3,1), imshow(newNN2); title(nnn2);
subplot(3,3,2), imshow(newNN4); title(nnn4);
subplot(3,3,3), imshow(newNN8); title(nnn8);
subplot(3,3,4), imshow(newBL2); title(nbl2);
subplot(3,3,5), imshow(newBL4); title(nbl4);
subplot(3,3,6), imshow(newBL8); title(nbl8);
subplot(3,3,7), imshow(newBC2); title(nbc2);
subplot(3,3,8), imshow(newBC4); title(nbc4);
subplot(3,3,9), imshow(newBC8); title(nbc8);

%% Same process with Antialiasing
bilinearFactor2 = imresize(original, 1/2, 'bilinear','Antialiasing',true);
bilinearFactor4 = imresize(original, 1/4, 'bilinear','Antialiasing',true);
bilinearFactor8 = imresize(original, 1/8, 'bilinear','Antialiasing',true);
nearestFactor2 = imresize(original, 1/2, 'nearest','Antialiasing',true);
nearestFactor4 = imresize(original, 1/4, 'nearest','Antialiasing',true);
nearestFactor8 = imresize(original, 1/8, 'nearest','Antialiasing',true);
bicubicFactor2 = imresize(original, 1/2, 'bicubic','Antialiasing',true);
bicubicFactor4 = imresize(original, 1/4, 'bicubic','Antialiasing',true);
bicubicFactor8 = imresize(original, 1/8, 'bicubic','Antialiasing',true);

newBL2 = imresize(bilinearFactor2, 2, 'bilinear','Antialiasing',true);
newBL4 = imresize(bilinearFactor4, 4, 'bilinear','Antialiasing',true);
newBL8 = imresize(bilinearFactor8, 8, 'bilinear','Antialiasing',true);
newNN2 = imresize(nearestFactor2, 2, 'nearest','Antialiasing',true);
newNN4 = imresize(nearestFactor4, 4, 'nearest','Antialiasing',true);
newNN8 = imresize(nearestFactor8, 8, 'nearest','Antialiasing',true);
newBC2 = imresize(bicubicFactor2, 2, 'bicubic','Antialiasing',true);
newBC4 = imresize(bicubicFactor4, 4, 'bicubic','Antialiasing',true);
newBC8 = imresize(bicubicFactor8, 8, 'bicubic','Antialiasing',true);

figure(3)
subplot(4,3,2), imshow(original); title('original image');
subplot(4,3,4), imshow(nearestFactor2);
title('nearest-neighbor (1/2 with A-A)');
subplot(4,3,5), imshow(nearestFactor4);
title('nearest-neighbor (1/4 with A-A)');
subplot(4,3,6), imshow(nearestFactor8);
title('nearest-neighbor (1/8 with A-A)');
subplot(4,3,7), imshow(bilinearFactor2);
title('bilinear (1/2 with A-A)');
subplot(4,3,8), imshow(bilinearFactor4);
title('bilinear (1/4 with A-A)');
subplot(4,3,9), imshow(bilinearFactor8);
title('bilinear (1/8 with A-A)');
subplot(4,3,10), imshow(bicubicFactor2);
title('bicubic (1/2 with A-A)');
subplot(4,3,11), imshow(bicubicFactor4);
title('bicubic (1/4 with A-A)');
subplot(4,3,12), imshow(bicubicFactor8);
title('bicubic (1/8 with A-A)');

errBL2 = immse(newBL2, original);
bl2 = sprintf('\n bilinear (1/2 with A-A), MSE: %0.1f\n', errBL2);
errBL4 = immse(newBL4, original);
bl4 = sprintf('\n bilinear (1/4 with A-A), MSE: %0.1f\n', errBL4);
errBL8 = immse(newBL8, original);
bl8 = sprintf('\n bilinear (1/8 with A-A), MSE: %0.1f\n', errBL8);

errNN2 = immse(newNN2, original);
nn2 = sprintf('\n nearest-neighbor (1/2 with A-A), MSE: %0.1f\n', errNN2);
errNN4 = immse(newNN4, original);
nn4 = sprintf('\n nearest-neighbor (1/4 with A-A), MSE: %0.1f\n', errNN4);
errNN8 = immse(newNN8, original);
nn8 = sprintf('\n nearest-neighbor (1/8 with A-A), MSE: %0.1f\n', errNN8);

errBC2 = immse(newBC2, original);
bc2 = sprintf('\n bicubic (1/2 with A-A), MSE: %0.1f\n', errBC2);
errBC4 = immse(newBC4, original);
bc4 = sprintf('\n bicubic (1/4 with A-A), MSE: %0.1f\n', errBC4);
errBC8 = immse(newBC8, original);
bc8 = sprintf('\n bicubic (1/8 with A-A), MSE: %0.1f\n', errBC8);

figure(4)
subplot(3,3,1), imshow(newNN2); title(nn2);
subplot(3,3,2), imshow(newNN4); title(nn4);
subplot(3,3,3), imshow(newNN8); title(nn8);
subplot(3,3,4), imshow(newBL2); title(bl2);
subplot(3,3,5), imshow(newBL4); title(bl4);
subplot(3,3,6), imshow(newBL8); title(bl8);
subplot(3,3,7), imshow(newBC2); title(bc2);
subplot(3,3,8), imshow(newBC4); title(bc4);
subplot(3,3,9), imshow(newBC8); title(bc8);

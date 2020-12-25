clear all;
close all;
clc;

%% preparation
I = imread('village.gif');
% Let us define some structuring elements here
% for ease of modularity.
seDiamond     = strel('diamond' , 5);
seDisk        = strel('disk'    , 3);
seDiskBig     = strel('disk'    , 7);
seLine        = strel('line'    , 3, 0);
seLineRotated = strel('line'    , 3, 90);
seSquare      = strel('square'  , 2);


%% Binarise
% edges = imdilate(I,seDiskBig)-imerode(I,seDisk);
% level = graythresh(uint8(edges));
level = 0.21345;
BW = im2bw(uint8(I),level);

figure();
subplot(1,2,1); imshow(I,'displayrange',[]);
title('Original Image.', 'FontSize', 15)

subplot(1,2,2); imshow(BW);
title('Binarized Image.', 'FontSize', 15)


%% UrbanDetect
detected = UrbanDetec('village.gif','out.gif',5,level-0.07);


%% Algorithm Implementation
%% Step 1 -- TH & BH
% TH by opening: WTH(f) = f − (f o B)
% (erosion followed by dilation)
TH = imerode(I,seDiamond);
TH = imdilate(TH,seDiamond);
TH = I - TH;

% BH by closing: BTH(f) = f − (f • B)
% (dilation followed by erosion)
BH = imdilate(I,seDiamond);
BH = imerode(BH,seDiamond);
BH = BH - I;
% plot
figure();
subplot(2,2,1); imshow(TH);
title('Our TopHat Image.', 'FontSize', 15)
subplot(2,2,2); imshow(imtophat(I,seDiamond));
title('TopHat Image using imtophat().', 'FontSize', 15)
subplot(2,2,3); imshow(BH);
title('BotHat Image.', 'FontSize', 15)
subplot(2,2,4); imshow(imbothat(I,seDiamond));
title('BotHat Image using imbothat().', 'FontSize', 15)


%% Step 2 -- Normalize
normTH = im2double(TH);
normBH = im2double(BH);


%% Step 3 -- Otsu
edgesTH  = imdilate(normTH,seDiskBig)-imerode(normTH,seDisk);
edgesBH  = imdilate(normBH,seDiskBig)-imerode(normBH,seDisk);
%
level    = graythresh(edgesTH);
BWITH = im2bw(normTH,level);
%
level    = graythresh(edgesBH);
BWIBH = im2bw(normBH,level);


%% Step 4
figure();
subplot(1,2,1); imshow(BWITH);
title('BWTH Image.', 'FontSize', 15)
subplot(1,2,2); imshow(BWIBH);
title('BWBH Image.', 'FontSize', 15)


%% Step 5
newTH = imopen(BWITH,seLine);
figure();
subplot(1,2,1); imshow(newTH);
title('newTH Image.', 'FontSize', 15)


%% Step 6
newBH = imopen(BWIBH,seLine);
newBH = imclose(newBH,seLineRotated);
subplot(1,2,2); imshow(newBH);
title('newBH Image.', 'FontSize', 15)


%% Step 7
fused = imfuse(newTH,newBH);
figure();
imshow(fused);
title('Fused Image.', 'FontSize', 15)


return;
%% Usefull Links 
% http://www.mi.fu-berlin.de/wiki/pub/ABI/QuantProtP4/signal-processing.pdf

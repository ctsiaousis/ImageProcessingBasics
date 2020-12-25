clear all;
close all;
clc;

%% preparation
I = imread('cell.png');
%let us detect edges
kernel = ones(5,5);
Ipad = padForConv(double(I),kernel,'fill');

topArea = Compute_Max(double(Ipad),kernel);
botArea = Compute_Min(double(Ipad),kernel);

figure(1);
subplot(2,1,1); imshow(uint8(cat(2,double(topArea),double(botArea))));
title('Left: 5x5 Max, Right: 5x5 Min.', 'FontSize', 15)
edge1 = topArea - botArea;
subplot(2,1,2); imshow(cat(2,I,uint8(edge1)));
title('Left: original, Right: Max - Min.', 'FontSize', 15)

edgePad = padForConv(double(edge1),ones(3,3),'fill');
edge1 = convolution_bonus(edgePad,[-1 0 -1]);
edge1 = -edge1(1:end-2,:); %dimetion fix

%% Otsu
level = graythresh(uint8(edge1));
BW = im2bw(uint8(edge1),level);

figure(2);
subplot(2,1,1); imshow(edge1,'displayrange',[]);
title('Our detected edges Image.', 'FontSize', 15)

subplot(2,1,2); imshow(BW,'displayrange',[]);
title('Otsu Method result.', 'FontSize', 15)

%% contour kai pame tour
se = strel('disk',12);
BWtour = imtophat(BW,se);

figure(3);
subplot(2,1,1); imshow(BWtour,'displayrange',[]);
title('The contoured image.', 'FontSize', 15)

%% fill
BWfill = imfill(BWtour,'holes');
subplot(2,1,2); imshow(BWfill,'displayrange',[]);
title('The filled image.', 'FontSize', 15)

%% eroses ar red
seD = strel('diamond',1);
BWfinal = imerode(BWfill,seD);
BWfinal = imerode(BWfinal,seD);

figure(4);
subplot(2,2,1); imshow(BWfinal,'displayrange',[]);
title('The erosed image.', 'FontSize', 15)


%%
BWnoborder = imclearborder(BWfinal,26);
subplot(2,2,2); imshow(BWnoborder,'displayrange',[]);
title('Cleared Border Image', 'FontSize', 15)

BWoutline = bwperim(BWnoborder(:,:,[1 1 1]));
Segout = I(:,:,[1 1 1]);
Segout(BWoutline) = 0;
subplot(2,2,3); imshow(Segout,'displayrange',[]);
title('Fancy Outlined Original Image', 'FontSize', 15)

BWoutline = bwperim(BWnoborder);
SegoutR = I;
SegoutG = I;
SegoutB = I;
%now set yellow, [255 255 0]
SegoutR(BWoutline) = 255;
SegoutG(BWoutline) = 0;
SegoutB(BWoutline) = 0;
SegoutRGB = cat(3, SegoutR, SegoutG, SegoutB);

subplot(2,2,4); imshow(SegoutRGB)
title('Outlined Original Image', 'FontSize', 15)
return;

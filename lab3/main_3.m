clear all;
close all;
clc;

I = imread('cameraman.tif');
I = double(I);

%% exercize 1

%-------------------1-------------------
g=fspecial('gaussian',5,1);

%----------------2-3-4-5----------------
g=fspecial('gaussian',5,1);
a = 1:1:4;              %levels of decomposition
N = numel(a);           %number of iterations
G = cell(N+1,1);        %the decomposition array
firstPad = padForConv(double(I),double(g),'fill');
firstConv= convolution(double(firstPad), double(g));
G{1} = firstConv;       %original image at 1st position
downSample = cell(N,1); %array of downsampled images
fillI = cell(N,1);      %array of padded images to convolve

% Note that G is bigger by one because it stores
% the original image aswell.

for k=1:N
    downSample{k} = imresize(G{k}, 1/2); %downsample the kth element of G
    fillI{k} = padForConv(double(downSample{k}),double(g),'fill'); %pad it
    G{k+1} = convolution(double(fillI{k}), double(g)); %conv and store G(k+1)
%     G{k+1} = uint8(G{k+1}); %make it uint8 so it is printable with imshow
end

ds = [1 2 4 8 16];  %just for titling the level of downsample
figure(1);          %Gaussian filter decomposition layers
for k=1:N+1
    subplot(1,N+1,k);
    tst = cell2mat(G(k));
    imagesc(tst)
    colormap gray
    str = sprintf('G(%d) decomposition', k-1);
    title(str, 'FontSize', 14, 'Color', 'r');
    str = sprintf('Gaussian pyramid, 1/%d downsample', ds(k));
    xlabel(str);
end
    colorbar

%% exercize 2

%-------------------1-------------------
L = cell(N,1);
upSample = cell(N,1);
for k=1:N
    upSample{k} = imresize(G{k+1},2);
    L{k} = G{k} - upSample{k};
end

%-------------------2-------------------
ds = [2 4 8 16 32];  %just for titling the level of upsample
figure(2);          %Laplacian filter decomposition layers
for k=1:N+1
    subplot(1,N+1,k);
    if k == 5
        tst = cell2mat(G(k));
    else
    tst = cell2mat(L(k));
    end
    imagesc(tst)
    colormap gray
    str = sprintf('L(%d) decomposition', k);
    title(str, 'FontSize', 14, 'Color', 'b');
    str = sprintf('Laplacian pyramid, %d upsample', ds(k));
    xlabel(str);
end
    colorbar

%-------------------3-------------------

reconstruct = cell(N,1);
for k=1:N
    reconstruct{k} = L{k} + G{k};
end

figure(3);
for k=1:N
    subplot(1,N,k);
    tst = cell2mat(reconstruct(k));
    imagesc(tst)
    colormap gray
    str = sprintf('L(%d) + G(%d)', k,k);
    title(str, 'FontSize', 14, 'Color', 'g');
    str = sprintf('Recovered Image, ratio 1:%d',k);
    xlabel(str);
end
    colorbar

mse1 = immse(double(cell2mat(reconstruct(1))), I);
psnr1 = psnr(double(cell2mat(reconstruct(1))), I);

fprintf('Now lets check the errors!\n')
fprintf('original : MSE: %0.2f\tPSNR: %0.2f\n',mse1, psnr1)
mse2 = immse(double(cell2mat(reconstruct(1))), double(firstConv));
psnr2 = psnr(double(cell2mat(reconstruct(1))), double(firstConv));
fprintf('convolved: MSE: %0.2f\tPSNR: %0.2f\n',mse2, psnr2)


clc;
clear all;
close all;

%% Bhma 1
I=imread('cameraman.tif');


%% Bhma 2
Inew=imresize(I,[30 30]);


%% FFT of Inew -- Bhma 3
%result of conv will be 38x38 so...
InewPad=zeros(38); %to do linear conv later
InewPad(1:30,1:30) = Inew;
FTnoShift=fft2(InewPad);
FT = fftshift(FTnoShift);

figure;
subplot(1,2,1)
imagesc(Inew); colormap gray;
title('$I_{new}$','Interpreter','latex')
subplot(1,2,2)
[X,Y] = meshgrid(-18.5:18.5);
s = mesh(X,Y,abs(FT)); s.FaceColor = [0.2 1 1];
s.EdgeColor = [1 0.5 0.2];
title('$\mathcal{F}\{I_{new}\}$','Interpreter','latex')


%% gaussian filter σ=0.8 -- Bhma 5
G=fspecial('gaussian',[9 9],0.8);

figure;
subplot(1,2,1)
[X,Y] = meshgrid(-4:4);
s = mesh(X,Y,G); s.FaceColor = 'flat';
colormap(parula(5))
title('Filter in spatial domain');


%% FFT of gaussian filter -- Bhma 6
% zero pad matricies to be 38x38
GFbig=zeros(38); %to do linear conv later
GFbig(1:9,1:9) = G;
GFnoShift=fft2(GFbig);
GF=fftshift(GFnoShift);
%%  Bhma 7
subplot(1,2,2)
[X,Y] = meshgrid(-18.5:18.5);
s = mesh(X,Y,abs(GF)); s.FaceColor = 'flat';
title('Filter in frequency domain');


%% Convolution in time -- Bhma 8
C = conv2(double(Inew),G);
figure;
subplot(1,2,1)
imagesc(C); colormap(gray);
title('Image filtered with gaussian in spatial domain');


%% F{Inew} · F{Guass} -- Bhma 9
%and multiply
K=GFnoShift .* FTnoShift;
subplot(1,2,2)
[X,Y] = meshgrid(-18.5:18.5);
s = mesh(X,Y,abs(GF)); s.FaceColor = 'flat';
title('$\mathcal{F}\{I_{new}\} \cdot \mathcal{F}\{Filter\}$','Interpreter','latex')


%% reverse fourier -- Bhma 10
conS=ifft2(K);
figure;
imagesc(abs(conS)); colormap(gray);
title('IFFT');


%% toeplitz convolution -- Bhma 11
[rows colsOriginal] = size(Inew);
cols = 38;
%--Lecture9/Slide15 G at bot left of Gpad
Gpad=zeros(cols);
Gpad(30:38,1:9) = G;

%--Lecture9/Slides17-21
H=cell(cols,1); % array of matricies
for i=1:cols
    %take line from bot to top
    x = Gpad(cols+1-i,:);
    %make it column
    x=x';
    %cicle it 30 times
    for k=1:rows
        t(:,k) = circshift(x,k-1);
    end
    H{i}= t; % H(i) is 38x1
end
%H{1..9} have values(the first elements),
% others are zero.

%--Lecture9/Slide23

finalH=cell(cols,cols);
for i=1:cols
    finalH(:,i)=circshift(H,i-1);
end
%cell of 38x30 matricies
final = finalH(:,1:30);
%with 38x30 dimensions

%Vectorize Inew
Ivec=Inew(:);  %900x1
final=cell2mat(final); %1444x900
conT=final*double(Ivec); %1444x1
conT=reshape(conT,cols,cols);

figure;
subplot(1,2,1)
imagesc(final); colormap(gray);
title('Toeplitz matrix (for debugging purpuses)');
subplot(1,2,2)
imagesc(conT); colormap(gray);
title('Convolution with Toeplitz matrix');



%% Mean square error -- Bhma 13
% %error between convoluted image and image from freq domain
er1=immse(C,conS);
fprintf('\n MSE(Conv, Freq) : %d', er1);
%error between convoluted image and image from toeplitz
er2=immse(C,conT);
fprintf('\n MSE(Conv, Toeplitz) : %d', er2);
% %error between image from toeplitz and image from freq domain
er3=immse(conT,conS);
fprintf('\n MSE(Toeplitz, Freq) : %d\n', er3);


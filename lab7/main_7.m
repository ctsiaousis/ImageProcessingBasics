clear all;
close all;
clc;

%% 1
A = [88 88 89 90 92 94 96 97]; %1.a
Ahaar = analysis(A,3) 

%% 2
Arec = synthesis(Ahaar,3)
assert(isequal(Arec,A),'Wrong Reconstruction')

%% extra .....next time =)
% I = double(magic(64));
% imagesc(I);
% figure
% imagesc(haar2analysis(I));
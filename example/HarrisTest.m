%Harris corner detector
clc;clear;close all;

addpath('..\..\VFX_HW2');
Path =  '..\TestImage\csie\IMG_8709.JPG';
I = imread(Path);

%% Parameter Settings:
sigma = 1.5; threshold = 3*1e+6; k =0.04; localRadius=3;

radius = 1; disp =10; thresh =1000;

%{
Y = rgb2ycbcr(I);
Y = Y(:,:,1);
C = corner( Y,'harris');
figure(1),imshow(I);
hold on;
plot(C(:,1), C(:,2), 'r*');
hold off;
%}

tic;
Corner = HarrisCornerDetector(I, sigma, k, threshold,localRadius);
display('HarrisCornerDetector run time is :');
toc;
figure(2),imshow(I);
hold on;
plot(Corner.c, Corner.r, 'r*');
hold off;

tic;
HarrisDiscriptor = BuildHarrisDescriptor(Corner, I);
display('BuildHarrisDiscriptor run time is :');
toc;
%[cim, r, c] = HarrisSampleCode(Y, sigma, thresh, radius, disp);
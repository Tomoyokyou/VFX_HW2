%MSOP corner detector
clc;clear;close all;

addpath('..\..\VFX_HW2');
Path =  '..\TestImage\csie\IMG_8709.JPG';
I = imread(Path);

%% Parameter Settings:
sigma = 1.5; sigma_smooth = 1; threshold = 10; k =0.04; localRadius=3;
mode = 'Strongest'; keypointNum = 100;


tic;
Corner = MSOPCornerDetector(I, sigma, sigma_smooth, k, threshold, localRadius, keypointNum, mode);
display('MSOPCornerDetector run time is :');
toc;
figure(2),imshow(I);
hold on;
plot(Corner.c, Corner.r, 'r*');
hold off;

%{
tic;
MSOPDiscriptor = BuildHarrisDescriptor(Corner, I);
display('BuildMSOPDiscriptor run time is :');
toc;
%}
%MSOP corner detector
clc;clear;close all;

addpath('../../VFX_HW2');
Path =  '../TestImage/dataset/4/DSC05019.JPG';
I = imread(Path);

%% Parameter Settings:
sigma = 1.5; sigma_smooth = 1; threshold = 10; k =0.04; localRadius=3;
mode = 'Strongest'; keypointNum = 100;

margin = 50;

tic;
Corner = MSOPCornerDetector(I, sigma, sigma_smooth, k, threshold, localRadius, keypointNum, margin,mode);
display('MSOPCornerDetector run time is :');
toc;
figure(2),imshow(I);
hold on;
plot(Corner.c, Corner.r, 'r*');
hold off;


tic;
MSOPDescriptor = BuildMSOPDescriptor(Corner, I);
display('BuildMSOPDescriptor run time is :');
toc;

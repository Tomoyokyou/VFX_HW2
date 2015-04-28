%Harris Test all
clc;clear;close all;

addpath('..\..\VFX_HW2');
Path1 =  '..\TestImage\csie\IMG_8709.jpg';
Path2 =  '..\TestImage\csie\IMG_8710.jpg';

I_in_1 = imread(Path1);
I_in_2 = imread(Path2);


%% Parameter Settings:
sigma = 1.5; threshold = 3*1e+6; k =0.04; localRadius=5;

focalLength = 2100;
img_cyl_shift = 20;


tic;
[ I_1 ] = cylProject( I_in_1, focalLength, img_cyl_shift  );
display('cylProject run time : ');
toc;

figure; imshow(I_1);

%Harris
margin = 40;

tic;
Corner_1 = HarrisCornerDetector(I_1, sigma, k, threshold, localRadius, margin);
display('HarrisCornerDetector run time is :');
toc;
figure(2),imshow(I_1);

hold on;
plot(Corner_1.c, Corner_1.r, 'r*');
hold off;

tic;
HarrisDiscriptor_1 = BuildHarrisDescriptor(Corner_1, I_1);
display('BuildHarrisDiscriptor run time is :');
toc;


%I2
tic;
[ I_2 ] = cylProject( I_in_2, focalLength, img_cyl_shift  );
display('cylProject run time : ');
toc;

figure;imshow(I_2);

tic;
Corner_2 = HarrisCornerDetector(I_2, sigma, k, threshold, localRadius);
display('HarrisCornerDetector run time is :');
toc;
figure;imshow(I_2);

hold on;
plot(Corner_2.c, Corner_2.r, 'r*');
hold off;

tic;
HarrisDiscriptor_2 = BuildHarrisDescriptor(Corner_2, I_1);
display('BuildHarrisDiscriptor run time is :');
toc;

%knn
matchNum = 50;
[ point_matched ] = knnMatch( HarrisDiscriptor_1, HarrisDiscriptor_2, matchNum );

%RANSAC
threshold = 100;
maxIter = 50;
[ vector_result inlierNum ] = RANSAC( point_matched, maxIter, threshold );
%align
[ img_result ] = alignImg( I_1, I_2, vector_result );

figure();imshow(img_result);


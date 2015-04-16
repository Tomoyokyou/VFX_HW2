%Harris corner detector
clc;clear;close all;


Path =  '..\TestImage\csie\IMG_8709.JPG';
I = imread(Path);

sigma = 3; threshold = 3*1e+6; k =0.04; localRadius=3;

radius = 10, disp =10, thresh =1000;

Y = rgb2ycbcr(I);
Y = Y(:,:,1);
C = corner( Y,'harris');
figure(1),imshow(I);
hold on;
plot(C(:,1), C(:,2), 'r*');
hold off;

Corner = HarrisCornerDetector(I, sigma, k, threshold,localRadius);
figure(2),imshow(I);
hold on;
plot(Corner.c, Corner.r, 'r*');
hold off;

[cim, r, c] = HarrisSampleCode(Y, sigma, thresh, radius, disp);
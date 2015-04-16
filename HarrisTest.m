%Harris corner detector
clc;clear;close all;


path =  'TestImage\csie\IMG_8709.JPG';
I = imread(path);

sigma = 10; threshold = 1e+5; k =0.04; localRadius=3;

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
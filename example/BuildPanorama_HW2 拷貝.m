%Build Panorama
clc;
clear;
close all;
addpath('../../VFX_HW2');


image = dir('../TestImage/dataset/7/*.jpg');
Path = '../TestImage/dataset/7/';
focalLength = 400;
img_cyl_shift = 20;

imageNum = size(image,1);
I_out = imread([Path image(8).name]);
I_out = imresize(I_out, 0.2);

tic;
    [ I_out ] = cylProject( I_out, focalLength, img_cyl_shift  );
    display('cylProject run time : ');
    toc;


for i = 9:imageNum
    
    
    i
    %figure; imshow(I_out);
	
    I_in_2 = imread([Path image(i).name]);
	I_in_2 = imresize(I_in_2, 0.2);
    
    tic;
    [ I_2 ] = cylProject( I_in_2, focalLength, img_cyl_shift  );
    display('cylProject run time : ');
    toc;

   %figure;imshow(I_2);
    
    
    
    I_out = stitchTwo_HW2(I_out, I_2,i);
end
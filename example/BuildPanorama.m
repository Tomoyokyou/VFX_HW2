%Build Panorama
clc;
clear;
close all;
addpath('../../VFX_HW2');


image = dir('../TestImage/csie/*.jpg');
Path = '../TestImage/csie/';
focalLength = 2100;
img_cyl_shift = 10;

imageNum = size(image,1);
I_out = imread([Path image(1).name]);
tic;
    [ I_out ] = cylProject( I_out, focalLength, img_cyl_shift  );
    display('cylProject run time : ');
    toc;


for i = 2:imageNum
    
    

    figure; imshow(I_out);
	
    I_in_2 = imread([Path image(i).name]);
	
    
    tic;
    [ I_2 ] = cylProject( I_in_2, focalLength, img_cyl_shift  );
    display('cylProject run time : ');
    toc;

    figure;imshow(I_2);
    
    
    
    I_out = stitchTwo(I_out, I_in_2);
end
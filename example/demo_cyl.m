clear all;
%% parameter
focalLength = 2100;
img_cyl_shift = 40;

addpath('..\..\VFX_HW2');
Path  = '..\TestImage\ntulib\IMG_8728.jpg';

%% cylinder projection
img_RGB = imread(Path);

tic;
[ img_out ] = cylProject( img_RGB, focalLength, img_cyl_shift  );
display('cylProject run time : ');
toc;

imshow(img_out);
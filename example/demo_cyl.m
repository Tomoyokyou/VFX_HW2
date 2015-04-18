clear all;
%% parameter
focalLength = 2100;
img_cyl_shift = 40;
%% cylinder projection
img_RGB = imread(['C:\Users\acer\Documents\NTUEE\¤j¥|¤U\DVE\hw2\ntulib\IMG_8728.jpg']);
[ img_out ] = cylProject( img_RGB, focalLength, img_cyl_shift  );
imshow(img_out);
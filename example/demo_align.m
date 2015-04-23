clear all;
%% parameter

%% cylinder projection
img_1 = imread(['C:\Users\acer\Documents\NTUEE\大四下\DVE\hw2\ntulib\IMG_8728.jpg']);
img_2 = imread(['C:\Users\acer\Documents\NTUEE\大四下\DVE\hw2\ntulib\IMG_8726.jpg']);
[ img_result ] = alignImg( img_1, img_2, [100 -2000] );
imshow(img_result);
%Build Panorama
clc;
clear;
close all;
addpath('..\..\VFX_HW2');


image = dir('../TestImage/csie/*.jpg');
Path = '../TestImage/csie/';
focallength = 2100;


imageNum = size(image,1);
I_out = imread([Path image(1).name]);


for i = 2:imageNum
	I_in2 = imread([Path image(i).name]);
	I_out = stitchTwo(I_out, I_in2, focallength)
end
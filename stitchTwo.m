function  img_result = stitchTwo(I_1, I_2)

%% Parameter Settings:
sigma = 1.5; threshold = 5*1e+6; k =0.04; localRadius= 3;

%focalLength = 2100;





%Harris
margin = 13;

tic;
Corner_1 = HarrisCornerDetector(I_1, sigma, k, threshold, localRadius, margin);
display('HarrisCornerDetector run time is :');
toc;
figure;imshow(I_1);

hold on;
plot(Corner_1.c, Corner_1.r, 'r*');
hold off;

tic;
HarrisDiscriptor_1 = BuildHarrisDescriptor(Corner_1, I_1);
display('BuildHarrisDiscriptor run time is :');
toc;


%I2


tic;
Corner_2 = HarrisCornerDetector(I_2, sigma, k, threshold, localRadius, margin);
display('HarrisCornerDetector run time is :');
toc;
figure;imshow(I_2);

hold on;
plot(Corner_2.c, Corner_2.r, 'r*');
hold off;

tic;
HarrisDiscriptor_2 = BuildHarrisDescriptor(Corner_2, I_2);
display('BuildHarrisDiscriptor run time is :');
toc;

%knn
matchNum = 30;	
[ point_matched distance ] = knnMatch( HarrisDiscriptor_1, HarrisDiscriptor_2, matchNum );

%RANSAC
threshold = 30;
maxIter = 5000;
[ vector_result inlierNum ] = RANSAC( point_matched, maxIter, threshold );
%align
[ img_result ] = alignImg( I_1, I_2, vector_result );

figure();imshow(img_result);


%%For debug
%{
figure();imshow(I_1);
hold on;
plot(point_matched(:,2), point_matched(:,1), 'r*');
hold off;

figure();imshow(I_2);
hold on;
plot(point_matched(:,4), point_matched(:,3), 'r*');
hold off;
%}
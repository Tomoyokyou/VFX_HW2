function  img_result = stitchTwo_MSOP(I_1, I_2)

%% Parameter Settings:
sigma = 1.5;  k =0.04; localRadius= 3;

sigma_smooth = 1; threshold = 10;

keypointNum = 250;
mode = 'Strongest';


%focalLength = 2100;

margin = 25;


Corner_1 = MSOPCornerDetector(I_1, sigma, sigma_smooth, k, threshold, localRadius, keypointNum, margin, mode);

%{
figure;imshow(I_1);

hold on;
plot(Corner_1.c, Corner_1.r, 'r*');
hold off;
%}

MSOPDescriptor_1 = BuildMSOPDescriptor(Corner_1, I_1);



%I2

Corner_2 = MSOPCornerDetector(I_2, sigma, sigma_smooth,k, threshold, localRadius, keypointNum, margin, mode);

%{
figure;imshow(I_2);

hold on;
plot(Corner_2.c, Corner_2.r, 'r*');
hold off;
%}

MSOPDescriptor_2 = BuildMSOPDescriptor(Corner_2, I_2);

%knn
matchNum = 40;	
[ point_matched distance ] = knnMatch( MSOPDescriptor_1, MSOPDescriptor_2, matchNum );

%RANSAC
threshold = 20;
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
function  img_result = stitchTwo_HW2(I_1, I_2, marginMultiple)

%% Parameter Settings:
sigma = 1.5;  k =0.04; localRadius= 1;

sigma_smooth = 1; threshold = 10;

keypointNum = 400;
mode = '';


%focalLength = 2100;

margin1.up = 300;
margin1.down = 100;
margin1.left = 200*(marginMultiple-1)*5;
margin1.right = 40*5;


margin2.up = 300;
margin2.down = 100;
margin2.left = 40*5;
margin2.right = 150*5;


Corner_1 = MSOPCornerDetector(I_1, sigma, sigma_smooth, k, threshold, localRadius, keypointNum, margin1, mode);

%{
figure;imshow(I_1);

hold on;
plot(Corner_1.c, Corner_1.r, 'r*');
hold off;
%}

MSOPDescriptor_1 = BuildMSOPDescriptor(Corner_1, I_1);



%I2

Corner_2 = MSOPCornerDetector(I_2, sigma, sigma_smooth,k, threshold, localRadius, keypointNum, margin2, mode);

%{
figure;imshow(I_2);

hold on;
plot(Corner_2.c, Corner_2.r, 'r*');
hold off;
%}

MSOPDescriptor_2 = BuildMSOPDescriptor(Corner_2, I_2);

%knn
matchNum = 200;	
[ point_matched distance ] = knnMatch( MSOPDescriptor_1, MSOPDescriptor_2, matchNum );

%RANSAC
threshold = 5;
maxIter = 10000;
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
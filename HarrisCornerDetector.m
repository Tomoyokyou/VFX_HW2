function Corner = HarrisCornerDetector(I, sigma, k, threshold, localRadius)

dy = fspecial('prewitt')
dx = dy';
Y = rgb2ycbcr(I);
Y = Y(:,:,1);

%Ix = conv2(double(Y), dx, 'same');   
%Iy = conv2(double(Y), dy, 'same'); 
Ix = imfilter(double(Y), dx, 'symmetric');
Iy = imfilter(double(Y), dy, 'symmetric');  

Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;

G = fspecial('gaussian', fix(sigma*6), sigma);
Sx2 = imfilter(Ix2,G, 'symmetric', 'conv');
Sy2 = imfilter(Iy2,G, 'symmetric', 'conv');
Sxy = imfilter(Ixy,G, 'symmetric', 'conv');



M = [Sx2, Sxy ; Sxy, Sy2];
R = (Sx2.*Sy2-Sxy.*Sxy) - k*(Sx2+Sy2);

%Find local maxima
localSize = 2*localRadius+1;
localMax = ordfilt2(R,localSize^2,ones(localSize)); % Grey-scale dilate.
%R = (R==localMax)&(R>threshold);  


[Corner.r Corner.c] = find(R>threshold&R==localMax);



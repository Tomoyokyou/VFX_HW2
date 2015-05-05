function Corner = HarrisCornerDetector(I, sigma, k, threshold, localRadius, margin)

dy = fspecial('prewitt');
dx = dy';
Y = rgb2ycbcr(I);
Y = Y(:,:,1);

%Ix = conv2(double(Y), dx, 'same');   
%Iy = conv2(double(Y), dy, 'same'); 
Ix = imfilter(double(Y), dx, 'replicate', 'conv');
Iy = imfilter(double(Y), dy, 'replicate', 'conv');  

Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;

G = fspecial('gaussian', fix(sigma*6), sigma);
Sx2 = imfilter(Ix2,G, 'replicate', 'conv');
Sy2 = imfilter(Iy2,G, 'replicate', 'conv');
Sxy = imfilter(Ixy,G, 'replicate', 'conv');



M = [Sx2, Sxy ; Sxy, Sy2];
R = (Sx2.*Sy2-Sxy.*Sxy) - k*(Sx2+Sy2).^2;

%Find local maxima
localSize = 2*localRadius+1;
localMax = ordfilt2(R,localSize^2,ones(localSize)); % Grey-scale dilate.
%R = (R==localMax)&(R>threshold);  


[tempCorner.r tempCorner.c] = find(R>threshold&R==localMax);

Index = find(tempCorner.r<(size(I,1)-margin)&tempCorner.r>margin&tempCorner.c<(size(I,2)-margin)&tempCorner.c>margin);

Corner.r = tempCorner.r(Index(:));
Corner.c = tempCorner.c(Index(:));
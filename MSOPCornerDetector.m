function Corner = MSOPCornerDetector(I, sigma, sigma_smooth,k, threshold, localRadius, keypointNum,mode)

dy = fspecial('prewitt');
dx = dy';
Y = rgb2ycbcr(I);
Y = Y(:,:,1);

%Ix = conv2(double(Y), dx, 'same');   
%Iy = conv2(double(Y), dy, 'same'); 
Ix = imfilter(double(Y), dx, 'replicate', 'conv');
Iy = imfilter(double(Y), dy, 'replicate', 'conv');  

G_smooth = fspecial('gaussian', fix(sigma_smooth*6), sigma_smooth);


%Ix = imfilter(Ix, G_smooth, 'replicate', 'conv');
%Iy = imfilter(Iy, G_smooth, 'replicate', 'conv');  


Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;

G = fspecial('gaussian', fix(sigma*6), sigma);
Sx2 = imfilter(Ix2,G, 'replicate', 'conv');
Sy2 = imfilter(Iy2,G, 'replicate', 'conv');
Sxy = imfilter(Ixy,G, 'replicate', 'conv');



%M = [Sx2, Sxy ; Sxy, Sy2];
R = (Sx2.*Sy2-Sxy.*Sxy)./(Sx2+Sy2);
R(find(isnan(R)))=0;

%Find local maxima
localSize = 2*localRadius+1;
localMax = ordfilt2(R,localSize^2,ones(localSize)); % Grey-scale dilate.


switch mode
	case 'ANMS'
		
	case 'Strongest'
		R(find(R~=localMax))=0;
		[R_sort, Index] = sort(R(:),'descend');
		%Corner.r = mod(Index(1:keypointNum),size(I,1));
		Corner.c = ceil(Index(1:keypointNum)./size(I,1));
		Corner.r = Index(1:keypointNum) - (Corner.c-1)*size(I,1);
	otherwise
	[Corner.r Corner.c] = find(R>threshold&R==localMax);
end
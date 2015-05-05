function Corner = MSOPCornerDetector(I, sigma, sigma_smooth,k, threshold, localRadius, keypointNum, margin, mode)

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

		tempCorner.c = ceil(Index(1:keypointNum)./size(I,1));
		tempCorner.r = Index(1:keypointNum) - (tempCorner.c-1)*size(I,1);

		Index2 = find(tempCorner.r<(size(I,1)-margin)&tempCorner.r>margin&tempCorner.c<(size(I,2)-margin)&tempCorner.c>margin);	

		Corner.r = tempCorner.r(Index2(:));
		Corner.c = tempCorner.c(Index2(:));

	otherwise
		R(find(R~=localMax))=0;
		[tempCorner.r tempCorner.c] = find(R>threshold&R==localMax);

		Index = find(tempCorner.r<(size(I,1)-margin.down)&tempCorner.r>margin.up&tempCorner.c<(size(I,2)-margin.right)&tempCorner.c>margin.left);	

		Corner.r = tempCorner.r(Index(:));
		Corner.c = tempCorner.c(Index(:));


end
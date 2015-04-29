function HarrisDiscriptor = BuildHarrisDescriptor(Corner, I)

Y = rgb2ycbcr(I);
Y = Y(:,:,1);

HarrisDiscriptor = zeros(size(Corner.r, 1), 11);

HarrisDiscriptor(:,1) = Corner.r;
HarrisDiscriptor(:,2) = Corner.c;

index = size(I,1).*(Corner.c-1)+Corner.r;
Max = size(I,1)*size(I,2);

for i = 1:9
	
	tempRow = mod(index, size(I,1));
	tempRow(find(tempRow==0)) = size(I,1);
	
	tempRow = tempRow + ceil(i/3)-2;
	tempCol = ceil(index./size(I,1)) + mod(i,3)-2;
	
	wrongIndex = find(tempRow>size(I,1));
	tempRow(wrongIndex,1) = size(I,1);
	
	wrongIndex = find(tempRow<1);
	tempRow(wrongIndex,1) = 1;
	
	wrongIndex = find(tempCol>size(I,2));
	tempCol(wrongIndex,1) = size(I,2);
	
	wrongIndex = find(tempCol<1);
	tempCol(wrongIndex,1) = 1;
	
	tempIndex = (tempCol-1)*size(I, 1) + tempRow;
	HarrisDiscriptor(:,i+2) = Y(tempIndex);
		
end








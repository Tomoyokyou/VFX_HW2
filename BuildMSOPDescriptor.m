function MSOPDescriptor = BuildMSOPDescriptor(Corner, I)

Y = rgb2ycbcr(I);
Y = Y(:,:,1);

MSOPscriptor = zeros(size(Corner.r, 1), 64);


MSOPDescriptor(:,1) = Corner.r;
MSOPDescriptor(:,2) = Corner.c;

index = size(I,1).*(Corner.c-1)+Corner.r;
Max = size(I,1)*size(I,2);


for pixel = 1:size(Corner.r, 1)
	for i = 1:8
		for j = 1:8
			tempRow = MSOPDescriptor(pixel, 1)-16+i*4;
			tempCol = MSOPDescriptor(pixel, 2)-16+j*4;
			if tempRow>size(I,1)
				tempRow = size(I,1);
			end

			if tempRow<1
				tempRow = 1;
			end

			if tempCol<1
				tempCol = 1;
			end

			if tempCol>size(I,2)
				tempCol = size(I,2);
			end

			MSOPDescriptor(pixel, i*j+2) = Y(tempRow, tempCol);
		end
	end
end





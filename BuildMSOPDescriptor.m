function MSOPDescriptor = BuildMSOPDescriptor(Corner, I)

Y = rgb2ycbcr(I);
Y = Y(:,:,1);

MSOPscriptor = zeros(size(Corner.r, 1), 11);






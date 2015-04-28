function [ img_result ] = alignImg( img_1, img_2, vector_result )
vector_result = [round(vector_result(1)) round(vector_result(2))];
cor_1 = [1 size(img_1,1) 1 size(img_1,2) ];%[up down left right]
cor_2 = [1+vector_result(1) size(img_2,1)+vector_result(1) 1+vector_result(2) size(img_2,2)+vector_result(2) ];
cor_result = [min(cor_1(1),cor_2(1)) max(cor_1(2),cor_2(2)) min(cor_1(3),cor_2(3)) max(cor_1(4),cor_2(4))];

tempImg_1 = zeros(cor_result(2)-cor_result(1)+1,cor_result(4)-cor_result(3)+1,3);
tempImg_2 = zeros(cor_result(2)-cor_result(1)+1,cor_result(4)-cor_result(3)+1,3);
corShift_row = 1-cor_result(1);
corShift_column = 1-cor_result(3);
tempImg_1( (cor_1(1)+corShift_row):(cor_1(2)+corShift_row) , (cor_1(3)+corShift_column):(cor_1(4)+corShift_column) , : ) = img_1;
tempImg_2( (cor_2(1)+corShift_row):(cor_2(2)+corShift_row) , (cor_2(3)+corShift_column):(cor_2(4)+corShift_column) , : ) = img_2;

[ img_result ] = blendImg( tempImg_1, tempImg_2, vector_result, cor_1, cor_2, cor_result, corShift_row, corShift_column );

end


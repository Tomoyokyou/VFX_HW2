function [ img_result ] = blendImg( tempImg_1, tempImg_2, vector_result, cor_1, cor_2, cor_result, corShift_row, corShift_column )
weight_1 = ones(size(tempImg_1,1),size(tempImg_1,2),3);
weight_2 = ones(size(tempImg_2,1),size(tempImg_2,2),3);
cor_overlap = [max(cor_1(1),cor_2(1)) min(cor_1(2),cor_2(2)) max(cor_1(3),cor_2(3)) min(cor_1(4),cor_2(4))];
for i=1:(cor_overlap(4)-cor_overlap(3)+1)
    weight_1( (cor_overlap(1)+corShift_row):(cor_overlap(2)+corShift_row) , cor_overlap(3)+i-1+corShift_column , : ) = i/(cor_overlap(4)-cor_overlap(3)+2);
    weight_2( (cor_overlap(1)+corShift_row):(cor_overlap(2)+corShift_row) , cor_overlap(3)+i-1+corShift_column , : ) = ((cor_overlap(4)-cor_overlap(3)+2)-i)/(cor_overlap(4)-cor_overlap(3)+2);
end
if vector_result(1,2)>0
    temp = weight_1;
    weight_1 = weight_2;
    weight_2 = temp;
end
img_result = uint8(tempImg_1.*weight_1+tempImg_2.*weight_2);

end


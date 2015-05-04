function [ img_result ] = blendImg( tempImg_1, tempImg_2, vector_result, cor_1, cor_2, cor_result, corShift_row, corShift_column )
weight_1 = ones(size(tempImg_1,1),size(tempImg_1,2),3);
weight_2 = ones(size(tempImg_2,1),size(tempImg_2,2),3);
cor_overlap = [max(cor_1(1),cor_2(1)) min(cor_1(2),cor_2(2)) max(cor_1(3),cor_2(3)) min(cor_1(4),cor_2(4))];
for i=1:(cor_overlap(4)-cor_overlap(3)+1)
    weight_1( (cor_overlap(1)+corShift_row):(cor_overlap(2)+corShift_row) , cor_overlap(3)+i-1+corShift_column , : ) = i/(cor_overlap(4)-cor_overlap(3)+2);
    weight_2( (cor_overlap(1)+corShift_row):(cor_overlap(2)+corShift_row) , cor_overlap(3)+i-1+corShift_column , : ) = ((cor_overlap(4)-cor_overlap(3)+2)-i)/(cor_overlap(4)-cor_overlap(3)+2);
end
% weight_1( (cor_overlap(1)+corShift_row):(cor_overlap(2)+corShift_row) , (cor_overlap(3)+corShift_column):(cor_overlap(4)+corShift_column) , : ) = 1;
% weight_2( (cor_overlap(1)+corShift_row):(cor_overlap(2)+corShift_row) , (cor_overlap(3)+corShift_column):(cor_overlap(4)+corShift_column) , : ) = 0;
if vector_result(1,2)>0
    temp = weight_1;
    weight_1 = weight_2;
    weight_2 = temp;
end
for i=1:(cor_overlap(2)-cor_overlap(1)+1)
    for j=1:(cor_overlap(4)-cor_overlap(3)+1)
        if tempImg_1(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)==zeros(1,1,3)
            weight_1(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)=0;
            weight_2(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)=1;
        end
        if tempImg_2(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)==zeros(1,1,3)
            weight_1(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)=1;
            weight_2(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)=0;
        end
    end
end
% figure();imshow(weight_1);
% figure();imshow(weight_2);
% figure();imshow(uint8(tempImg_1));
% figure();imshow(uint8(tempImg_2));

img_result = uint8(tempImg_1.*weight_1+tempImg_2.*weight_2);

end


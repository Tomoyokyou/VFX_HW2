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
img_result_mid = tempImg_1.*weight_1+tempImg_2.*weight_2;
if 0
    img_result = uint8(img_result_mid);
else %poisson
    %weight_blendpatch
    weight_blendpatch = zeros(size(tempImg_1,1),size(tempImg_1,2),3);
    for i=1:(cor_overlap(2)-cor_overlap(1)+1)
        for j=1:(cor_overlap(4)-cor_overlap(3)+1)
            if tempImg_1(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)~=zeros(1,1,3)
                weight_blendpatch(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:) = 1;
            end
        end
    end
    %median filter
    weight_blendpatch(:,:,1) = medfilt2(weight_blendpatch(:,:,1),[5 5]);
    weight_blendpatch(:,:,2) = medfilt2(weight_blendpatch(:,:,2),[5 5]);
    weight_blendpatch(:,:,3) = medfilt2(weight_blendpatch(:,:,3),[5 5]);
    %weight_blendpatch_shrinked
    weight_blendpatch_shrinked = zeros(size(tempImg_1,1),size(tempImg_1,2),3);
    for i=1:(cor_overlap(2)-cor_overlap(1)+1)
        for j=1:(cor_overlap(4)-cor_overlap(3)+1)
            if weight_blendpatch((cor_overlap(1)+i-1+corShift_row-2):(cor_overlap(1)+i-1+corShift_row+2),(cor_overlap(3)+j-1+corShift_column-2):(cor_overlap(3)+j-1+corShift_column+2),:)==ones(5,5,3)
                weight_blendpatch_shrinked(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:) = 1;
            end
        end
    end
    %img_blendpatch
    img_blendpatch = tempImg_1.*weight_blendpatch;
    figure();imshow(img_blendpatch);
    % gradient
    globalGradient_H = imfilter(img_result_mid,[ 0,-1, 1 ],'replicate');
    globalGradient_V = imfilter(img_result_mid,[ 0;-1; 1 ],'replicate');
    localGradient_H = imfilter(img_blendpatch,[ 0,-1, 1 ],'replicate');
    localGradient_V = imfilter(img_blendpatch,[ 0;-1; 1 ],'replicate');
    gradient_H = globalGradient_H;
    gradient_V = globalGradient_V;
    for i=1:(cor_overlap(2)-cor_overlap(1)+1)
        for j=1:(cor_overlap(4)-cor_overlap(3)+1)
            if weight_blendpatch_shrinked(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:)==ones(1,1,3)
                img_result_mid(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:) = tempImg_1(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:);
                gradient_H(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:) = localGradient_H(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:);
                gradient_V(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:) = localGradient_V(cor_overlap(1)+i-1+corShift_row,cor_overlap(3)+j-1+corShift_column,:);
            end
        end
    end
%     figure();imshow(uint8(img_result_mid));
    img_blended = poissonBlend( img_result_mid, gradient_H, gradient_V, weight_blendpatch_shrinked );
    img_result = uint8(img_blended);
end
end



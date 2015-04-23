function [ vector_result inlierNum ] = RANSAC( point_matched, maxIter, threshold )
voteBoard = zeros(maxIter,2);
vector_matched = point_matched(:,1:2)-point_matched(:,3:4);
for i=1:maxIter
    temp = randperm(size(point_matched,1));
    voteBoard(i,1) = temp(1);
    for j=1:size(point_matched,1)
        if norm(vector_matched(j,:)-vector_matched(voteBoard(i,1),:),2)<threshold
            voteBoard(i,2) = voteBoard(i,2)+1;
        end
    end
end
[inlierNum, idx] = max(voteBoard(:,2));
vector_inlier = [];
for i=1:size(point_matched,1)
    if norm(vector_matched(i,:)-vector_matched(voteBoard(idx,1),:),2)<threshold
        vector_inlier = [vector_inlier; vector_matched(i,:)];
    end
end
if inlierNum~=size(vector_inlier,1)
    fprintf('something is wrong!');
end
    vector_result = mean(vector_inlier);

    
end


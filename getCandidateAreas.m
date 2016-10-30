%This function analyses each cluster for a specified frame, and returns the
%cluster ID numbers which are more than 50% of the largest cluster.

function [ candidateIdx ] = getCandidateAreas( IDX, currentFamePoints )

k=max(IDX);
areaMatrix = zeros(k,2);

if k > 0
    for i=1:k
        area = size(currentFamePoints(IDX==i,:));
        area = area(1,1);
        newRow = [i area];   
        areaMatrix(i,:) = newRow; 
    end
   
    maxArea = max(areaMatrix,[],1);
    maxArea = maxArea(1,2);
    X=[];
    count = 0;
    for i=1:k
        areaPrecentage = areaMatrix(i,2) * 100/maxArea;
        if areaPrecentage > 50
            count = count +1;
            X(count,:)= i;
        end
    end

    candidateIdx = X;
else
    candidateIdx = [];
end
end





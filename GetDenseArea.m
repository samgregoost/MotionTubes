function [ Yi, r ] = GetDenseArea( Xi , precentage)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
X=GetCentroid(Xi);
D=pdist2(Xi,X);
radius = max(D);
radius = floor(radius);
totalPointCount = size(Xi,1);
X = [];

for i= radius:-1:0
   
    idx = rangesearch(Xi,GetCentroid(Xi),i,'Distance','chebychev');
    pointPrecentage = size(idx{1},2)*100/totalPointCount;
    
    if pointPrecentage < 80
        break;
    end
    
end


Yi= Xi(idx{1},:);
r = i;


end


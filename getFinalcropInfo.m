function [ tubeInformation ] = getFinalcropInfo( Xi )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
[frameNum,columnCount] = size(unique(Xi(:,1:1)));
Xi
cellCount = 0;
for i = 1:15:frameNum-30
 

 startFramNum = find(Xi(:,1:1)>=i,1);
 endFramNum = find(Xi(:,1:1)>=i+29,1);
 temporalSegement = Xi(startFramNum:endFramNum,:);
 [a,b]=hist(temporalSegement(:,1:1),unique(temporalSegement(:,1:1)));
 meanClusterNum = floor(mean(a))
 b
 temporalSegement
 
 

 
 index = find(a(:)==meanClusterNum,1);
 while(isempty(index))
     meanClusterNum = meanClusterNum + 1;
     index = find(a(:)==meanClusterNum,1);
 end
meanFramNum = b(index,1)
 
 frameNum2 = temporalSegement(end,1:1);

 temporalSegement = formatClusterInfo(temporalSegement,meanClusterNum, meanFramNum, frameNum2)
 
 
 tubeMatrix = [];
 count = 0;
 
 for j = 1:meanClusterNum    
     
     ind1 = temporalSegement(:,1) ==temporalSegement(1,1:1) ;
     currentFrameMatrix = temporalSegement(ind1,:)
     newRow2 = [j  temporalSegement(1,1:1) currentFrameMatrix(1,3:3) currentFrameMatrix(1,4:4) currentFrameMatrix(1,5:5)]; 
     count =count + 1;
     tubeMatrix(count,:) = newRow2;
     
     for k = temporalSegement(1,1:1):frameNum2-1
         
         
         ind1 = temporalSegement(:,1) == k;
         currentFrameMatrix = temporalSegement(ind1,:);
         ind2 = temporalSegement(:,1) == k+1;
         nextFrameMatrix = temporalSegement(ind2,:);
         distanceMatrix = pdist2(currentFrameMatrix,nextFrameMatrix);
         [M,I] = min(distanceMatrix,[],2);
         newRow2 = [j k+1 nextFrameMatrix(I(1,1),3:3) nextFrameMatrix(I(1,1),4:4) nextFrameMatrix(I(1,1),5:5)]; 
         count =count + 1;
         tubeMatrix(count,:) = newRow2;
         
         deleteInd = temporalSegement(:,1) == k & temporalSegement(:,2) == j;
         temporalSegement(deleteInd,:) = [];
     end
 end
 cellCount = cellCount + 1;
 tubeInfo{cellCount} =  tubeMatrix;
end
 tubeInformation = tubeInfo;
end


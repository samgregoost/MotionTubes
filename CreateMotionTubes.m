function [ tubeCell ] = CreateMotionTubes( fileName)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

tree = xmlread(fileName);
allListitems = tree.getElementsByTagName('POINT');

valueMatrix = zeros(allListitems.getLength, 3);

for k = 0:allListitems.getLength-1
    
    
    currentItem = allListitems.item(k);
    values =  strsplit(char(currentItem.getFirstChild.getData));
    
    frameNum = str2double(char(values(1)));
    xValue = floor(str2double(char(values(3))));
    yValue = floor(str2double(char(values(2))));

    newRow = [frameNum xValue yValue];
    
    valueMatrix(k+1,:) = newRow;
    
    
    
end

maxVal = max(valueMatrix,[],1);
maxVal = maxVal(1,1);

candidateClusterInfo = []; % [frameNumber clusterID, Xi, Yi, r]
count = 0;
for i = 1:maxVal
    
    ind1 = valueMatrix(:,1) == i;
    currentFamePoints = valueMatrix(ind1,2:3);
    epsilon=8;
    MinPts=10;
    IDX=DBSCAN(currentFamePoints,epsilon,MinPts);
    
    candidateIdx = getCandidateAreas(IDX, currentFamePoints);
    
    numClusters = size(candidateIdx);
    numClusters = numClusters(1,1);
    
    for j = 1:numClusters
        
        candidatePoints = currentFamePoints(IDX == candidateIdx(j,1),:);
        [candidatePoints, radius] = GetDenseArea(candidatePoints,90);
        Centroid = GetCentroid(candidatePoints);
        
        newRow = [i j Centroid(1,1) Centroid(1,2)  radius];
        count = count + 1;
        candidateClusterInfo(count,:) = newRow;
        
    end
    


end

tubeCell = getFinalcropInfo(candidateClusterInfo);

end


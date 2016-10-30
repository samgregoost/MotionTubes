function [ Yi ] = formatClusterInfo( Xi,meanClusterNum, meanClusterFrameNum, frameNum )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
finalMat = [];

meanClusterFrameNum
meanClusterNum
Xi

for i = meanClusterFrameNum:frameNum

    idx = Xi(:,1) == i;
    tempMat = Xi(idx,:);    
    [rowCount columnCount] = size(tempMat)
        
    if rowCount > meanClusterNum
        excess = rowCount - meanClusterNum;
        sortedTempMat=sortrows(tempMat,5);    
        sortedTempMat = sortedTempMat(1:end-excess,:);
        finalMat = vertcat(finalMat,sortedTempMat);  
        
    elseif rowCount < meanClusterNum
        sub = meanClusterNum - rowCount;
        if (i== meanClusterFrameNum)
            idx = Xi(:,1) == i-1;
            tempMat2 = Xi(idx,:);
        else
             idx = finalMat(:,1) == i-1;
            tempMat2 = finalMat(idx,:);
        end
        
       
        for k = 1:sub
            tempMat3 = vertcat(tempMat,tempMat2)
            [r c] = size(tempMat3);
            if r > 1
                meanMat = mean(tempMat3(:,3:5));
            else
                meanMat = tempMat3(:,3:5);
            end
            
            
            newRow = [i rowCount+k meanMat(1,1), meanMat(1,2) meanMat(1,3)]
            tempMat = vertcat(tempMat, newRow);
            finalMat = vertcat(finalMat,tempMat);
        end
    else
        finalMat = vertcat(finalMat,tempMat);
    end
    
end


startFrame = Xi(1,1);

for i = meanClusterFrameNum-1:-1:startFrame

     idx = Xi(:,1) == i;
    tempMat = Xi(idx,:);
    
    [rowCount columnCount] = size(tempMat)

        
    if rowCount > meanClusterNum
        excess = rowCount - meanClusterNum;
        sortedTempMat=sortrows(tempMat,5);    
        sortedTempMat = sortedTempMat(1:end-excess,:);
        finalMat = vertcat(finalMat,sortedTempMat);  
        
    elseif rowCount < meanClusterNum
        sub = meanClusterNum - rowCount;
         if (i== meanClusterFrameNum)
            idx2 = Xi(:,1) == i+1;
            tempMat2 = Xi(idx2,:);
        else
             idx2 = finalMat(:,1) == i+1;
        tempMat2 = finalMat(idx2,:);
        end
       
            
        for k = 1:sub
            tempMat3 = vertcat(tempMat,tempMat2);
            [r c] = size(tempMat3);
            if r > 1
                meanMat = mean(tempMat3(:,3:5));
            else
                meanMat = tempMat3(:,3:5);
            end
            newRow = [i rowCount+k meanMat(1,1), meanMat(1,2) meanMat(1,3)]
            tempMat = vertcat(tempMat, newRow);
            finalMat = vertcat(finalMat,tempMat);
        end
    else
        finalMat = vertcat(finalMat,tempMat);
    end
    
end
finalMat
Yi = sortrows(finalMat,1);
end


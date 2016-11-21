function [ output_args ] = CreatePoticFlows(cellInput, videoFilePath, cellNumber, cellName )

%example usage = CreatePoticFlows(tubeCell, '/home/sameera/Documents/Mphil/Datasets/UCF11_updated_mpg/biking/v_biking_01/v_biking_01_01.mpg',8,'test2');


videoReader = vision.VideoFileReader(videoFilePath,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');



for count = 1:cellNumber
    Xi = cellInput{count};
    tubeCount  = unique(Xi(:,1:1));
    opticFlowInfo = [];
    opticRowCount = 0;
    for i = 1:tubeCount
    idx = Xi(:,1) == i;
    tubeSegment = Xi(idx,2:5);
        for ii = 1:size(tubeSegment,2)
            I = tubeSegment(1,ii);
            for jj = 2:size(tubeSegment,1)
                if isnan(tubeSegment(jj,ii))
                tubeSegment(jj,ii) = I;
                else
                I  = tubeSegment(jj,ii);
                end
            end
        end
     
    startFrameNumber = tubeSegment(1,1);
    endFrameNumber = tubeSegment(end,1);
    
    
    [rowCount columnCount] = size(tubeSegment);
    for jj = 1:startFrameNumber
        currentFrame = step(videoReader);
    end
    
    
    maxRad = max(tubeSegment);
    maxRad = floor(maxRad(1,4));
    
    [height width] = size(currentFrame);
    
    
    currentX1Coordinate = floor(tubeSegment(1, 2) - maxRad);
        if currentX1Coordinate < 1
            currentX1Coordinate = 1;
        end
        currentY1Coordinate = floor(tubeSegment(1, 3) - maxRad);
        if currentY1Coordinate < 1
            currentY1Coordinate = 1;
        end
        currentX2Coordinate = floor(tubeSegment(1, 2) + maxRad);
        if currentX2Coordinate > width
            currentX2Coordinate = width;
        end
        currentY2Coordinate = floor(tubeSegment(1,3) + maxRad);
        if currentY2Coordinate > height
            currentY2Coordinate = height;
        end
    
        currentCroppedFrame = currentFrame(currentX1Coordinate:currentX2Coordinate,currentY1Coordinate:currentY2Coordinate);
        currentCroppedFrame = imresize(currentCroppedFrame, [maxRad maxRad]);
        currentCroppedFrame = double(currentCroppedFrame);
        
        for j = 2:rowCount-1
        
       
        nextX1Coordinate = floor(tubeSegment(j, 2) - maxRad);
        if nextX1Coordinate < 1
            nextX1Coordinate = 1;
        end
        nextY1Coordinate = floor(tubeSegment(j, 3) - maxRad);
        if nextY1Coordinate < 1
            nextY1Coordinate = 1;
        end
        nextX2Coordinate = floor(tubeSegment(j, 2) + maxRad);
        if nextX2Coordinate > width
            nextX2Coordinate = width;
        end
        nextY2Coordinate = floor(tubeSegment(j,3) + maxRad);
        if nextY2Coordinate > height
            nextY2Coordinate = height;
        end
        
        nextFrame = step(videoReader);
        
%         nextX1Coordinate
%         nextX2Coordinate
%         nextY1Coordinate
%         nextY2Coordinate

        nextCroppedFrame = nextFrame( nextY1Coordinate:nextY2Coordinate, nextX1Coordinate:nextX2Coordinate);
       

        nextCroppedFrame = imresize(nextCroppedFrame, [maxRad maxRad]);

        nextCroppedFrame = double(nextCroppedFrame);

        opticalFlow = vision.OpticalFlow('ReferenceFrameSource', 'Input port');
        opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';
        opticFlowFrame = step(opticalFlow,nextCroppedFrame,currentCroppedFrame);

        opticRowCount = opticRowCount + 1;
        opticFlowInfo(:,:,opticRowCount) = opticFlowFrame;
        opticalFlow.release;
        currentCroppedFrame = nextCroppedFrame;
        end
    
    videoReader.reset;
    end
    file = strcat(cellName, '_', int2str(count));
    save(file,'opticFlowInfo');
end



end


S = '../../MotionTubes/'
k = dir(S);

fileCount = size(k,1)

for i= 1:fileCount
    nameLength = size(k(i).name,2)
    try
    if nameLength > 3
        name = k(i).name;
        
       % name = name(2:end-4)
        disp(name);
        fileName = strcat(S, name);
        tubeCell= CreateMotionTubes(fileName);
        name = name(1:end-8);
        name = strcat('../../MotionTubes/',name);
        save(name,'tubeCell');
    end
    catch
    end
end

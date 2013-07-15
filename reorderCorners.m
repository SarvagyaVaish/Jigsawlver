function ordered = reorderCorners(unordered)
    center = sum(unordered)/4;
    angles = ones(4,1);
    
    for i=1:4
       pair1 = unordered(i, :)-center;
    
       angle1 = atand(pair1(1,1)/pair1(1,2));
       if pair1(1,2)<0
           angle1 = angle1 + 180;
       end
       angle1 = 360 - angle1;
       
       angles(i) = angle1;
    end
    
    sorted = sortrows([angles unordered], 1);
    ordered = sorted(:, 2:3);
end
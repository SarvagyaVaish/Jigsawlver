function rotatedPoint = rotatePoint(pointToRotate, centerPoint, angleInDegrees)
    cosTheta = cosd(angleInDegrees);
    sinTheta = sind(angleInDegrees);
    rotatedPoint = [(cosTheta * (pointToRotate(1,2) - centerPoint(1,2)) - sinTheta * (pointToRotate(1,1) - centerPoint(1,1)) + centerPoint(1,2)) ...
            (sinTheta * (pointToRotate(1,2) - centerPoint(1,2)) + cosTheta * (pointToRotate(1,1) - centerPoint(1,1)) + centerPoint(1,1))];
end
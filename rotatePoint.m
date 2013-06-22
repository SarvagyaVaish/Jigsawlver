function rotatedPoint = rotatePoint(pointToRotate, centerPoint, angleInDegrees)
    cosTheta = cosd(angleInDegrees);
    sinTheta = sind(angleInDegrees);
    rotatedPoint = [(cosTheta * (pointToRotate.X - centerPoint.X) - sinTheta * (pointToRotate.Y - centerPoint.Y) + centerPoint.X) ...
            (sinTheta * (pointToRotate.X - centerPoint.X) + cosTheta * (pointToRotate.Y - centerPoint.Y) + centerPoint.Y)];
end
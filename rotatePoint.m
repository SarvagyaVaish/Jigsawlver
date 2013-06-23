function rotated_point = rotatePoint(point_to_rotate, center_point, angle_in_deg)
%     cosTheta = cosd(angleInDegrees);
%     sinTheta = sind(angleInDegrees);
%     rotatedPoint = [(cosTheta * (pointToRotate(1,2) - centerPoint(1,2)) - sinTheta * (pointToRotate(1,1) - centerPoint(1,1)) + centerPoint(1,2)) ...
%             (sinTheta * (pointToRotate(1,2) - centerPoint(1,2)) + cosTheta * (pointToRotate(1,1) - centerPoint(1,1)) + centerPoint(1,1))];

angle_in_deg = -angle_in_deg;
rot = [cosd(angle_in_deg), -sind(angle_in_deg); sind(angle_in_deg), cosd(angle_in_deg)];
rotated_point = rot*(point_to_rotate'-center_point') + center_point';
rotated_point = rotated_point';

end
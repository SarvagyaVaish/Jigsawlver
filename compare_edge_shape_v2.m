function [shape_match_score, match_position, match_rotation] = compare_edge_shape_v2(edge_1, edge_2)
global pieces; clc;

for ang_1 = 0:20:400
	for ang_2 = 0:20:400
		piece1 = rotatePiece(pieces{edge_1(1, 1)}, ang_1);
		piece2 = rotatePiece(pieces{edge_2(1, 1)}, ang_2);
		
		piece1_corners_ind = (0:2) + edge_1(1, 2);
		piece1_corners_ind(piece1_corners_ind > 4) = piece1_corners_ind(piece1_corners_ind > 4)-4;
		piece2_corners_ind = (0:2) + edge_2(1, 2);
		piece2_corners_ind(piece2_corners_ind > 4) = piece2_corners_ind(piece2_corners_ind > 4)-4;
		
		pair1a = piece1.Corners(piece1_corners_ind(1), :);
		pair1b = piece1.Corners(piece1_corners_ind(2), :);
		pair2a = piece2.Corners(piece2_corners_ind(1), :);
		pair2b = piece2.Corners(piece2_corners_ind(2), :);
		
		m1 = twoPointSlopeRC(pair1a, pair1b);
		m2 = twoPointSlopeRC(pair2a, pair2b);
		
		match_rotation = atand(abs((m1-m2)/(1+m1*m2)));
		
		if atand(m1) > atand(m2)
			match_rotation = -match_rotation;
		end
		
		% rotate piece2 to align with piece1
		piece3 = rotatePiece(piece2, match_rotation);
		piece3_corners_ind = (0:2) + edge_2(1, 2);
		piece3_corners_ind(piece3_corners_ind > 4) = piece3_corners_ind(piece3_corners_ind > 4)-4;
		
		% Check if you need to rotate piece2 by 180 to
		% align the correct side of the edges
		% The other corners (c) should be on opposite sides
		% of the line joining corners a and b
		pair1c = piece1.Corners(piece1_corners_ind(3), :);
		pair3c = piece3.Corners(piece1_corners_ind(3), :);
		
		
		if ~are_points_on_opposite_sides(pair1c, pair3c, pair1a, pair1b)
			piece3 = rotatePiece(piece3, 180);
		end
		
		pair3a = piece3.Corners(piece3_corners_ind(1), :);
		pair3b = piece3.Corners(piece3_corners_ind(2), :);
		m3 = twoPointSlopeRC(pair3a, pair3b);
		
		
		figure;
		subplot(1, 3, 1);
		hold on;
		imshow(piece1.Image);
		plot(pair1a(1, 1), pair1a(1, 2), 'or', 'MarkerSize', 10);
		plot(pair1b(1, 1), pair1b(1, 2), 'or', 'MarkerSize', 10);
		subplot(1, 3, 2);
		hold on;
		imshow(piece2.Image);
		plot(pair2a(1, 1), pair2a(1, 2), 'or', 'MarkerSize', 10);
		plot(pair2b(1, 1), pair2b(1, 2), 'or', 'MarkerSize', 10);
		subplot(1, 3, 3);
		hold on;
		imshow(piece3.Image);
		plot(pair3a(1, 1), pair3a(1, 2), 'or', 'MarkerSize', 10);
		plot(pair3b(1, 1), pair3b(1, 2), 'or', 'MarkerSize', 10);
		caption = [num2str(ang_1), '   ', num2str(ang_2)];
		text(-5, -50, caption) ;
	end
end

% pair1 = pair1a - pair1b;
% pair2 = pair2b - pair2a;
%
% angle1 = atand(pair1(1,1)/pair1(1,2));
% if pair1(1,2)<0
%     angle1 = angle1 + 180
% end
% angle2 = atand(pair2(1,1)/pair2(1,2));
% if pair2(1,2)<0
%     angle2 = angle2 + 180
% end
%
% match_rotation = angle1 - angle2;
% piece2 = rotatePiece(piece2, match_rotation);
%
% dist1 = sqrt(sum(pair1.^2));
% dist2 = sqrt(sum(pair2.^2));
%
% currentPosition = [];
% endPosition = dist1;
%
% if dist2 <= dist1
%     currentPosition = 0;
%     endPosition = dist1 - dist2;
% else
%     endPosition = 0;
%     currentPosition = dist1 - dist2;
% end
%
% shape_match_score = inf;
% match_position = currentPosition;
% while currentPosition <= endPosition
%     currentScore %DELETE
%
%     comparisonSpace = zeros(size(piece1) + 2*size(piece2) + [5,5]);
%     size1 = size(piece1);
%     size2 = size(piece2);
%     comparisonSpace(size2(1,1)+1:size2(1,1)+1+size1(1,1), size2(1,2)+1:size2(1,2)+1+size1(1,2)) = piece1.ImageBW;
%
%
%     xor
%     shiftedPiece2 = %INSERT TRANSFORMATION HERE
%
%
%
%
%
%     if currentScore < shape_match_score
%        shape_match_score = currentScore;
%        match_position = currentPosition;
%     end
%     currentPosition = currentPosition + 5;
% end

end
function [shape_match_score, match_position, match_rotation] = compare_edge_shape(edge_1, edge_2)

global pieces;
piece1 = pieces{edge_1(1, 1)};
piece2 = pieces{edge_2(1, 1)};

pair1a = piece1.Corners(edge_1(1, 2), :);
pair1b = piece1.Corners(mod(edge_1(1, 2), 4) + 1, :);
pair2a = piece2.Corners(edge_2(1, 2), :);
pair2b = piece2.Corners(mod(edge_2(1, 2), 4) + 1, :);

pair1 = pair1a - pair1b;
pair2 = pair2b - pair2a;

angle1 = atand(pair1(1,1)/pair1(1,2));
if pair1(1,2)<0
    angle1 = angle1 + 180
end
angle2 = atand(pair2(1,1)/pair2(1,2));
if pair2(1,2)<0
    angle2 = angle2 + 180
end

match_rotation = angle1 - angle2;
piece2 = rotatePiece(piece2, match_rotation);

dist1 = sqrt(sum(pair1.^2));
dist2 = sqrt(sum(pair2.^2));

currentPosition = [];
endPosition = dist1;

if dist2 <= dist1
    currentPosition = 0;
    endPosition = dist1 - dist2;
else
    endPosition = 0;
    currentPosition = dist1 - dist2;
end

shape_match_score = inf;
match_position = currentPosition;
while currentPosition <= endPosition
    currentScore %DELETE
    
    comparisonSpace = zeros(size(piece1) + 2*size(piece2) + [5,5]);
    size1 = size(piece1);
    size2 = size(piece2);
    comparisonSpace(size2(1,1)+1:size2(1,1)+1+size1(1,1), size2(1,2)+1:size2(1,2)+1+size1(1,2)) = piece1.ImageBW;
    
    
    xor
    shiftedPiece2 = %INSERT TRANSFORMATION HERE
    
    
    
    
    
    if currentScore < shape_match_score
       shape_match_score = currentScore;
       match_position = currentPosition;
    end
    currentPosition = currentPosition + 5;
end

% subplot(1, 2, 1);
% imshow(pieces{edge_1(1, 1)}.Image)
% edge_1(1, 2)
% subplot(1, 2, 2);
% imshow(pieces{edge_2(1, 1)}.Image)
% edge_2(1, 2)
% 
% reply = questdlg(['Does the SHAPE match', num2str(edge_1(1, 2)), num2str(edge_2(1, 2))], '', 'Yes', 'No', 'No');
% 
% if strcmp(reply, 'No')
% 	shape_match_score = 1000;
% elseif strcmp(reply, 'Yes')
% 	shape_match_score = 0;
% else
% 	error('your quitting error message')
% end
% 
% match_position = 0;

end
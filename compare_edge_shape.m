function [shape_match_score, match_rotation] = compare_edge_shape(edge_1, edge_2)
% PARAMS
edge_length_threshold = .05;
fit_mask_width = 60;


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
	angle1 = angle1 + 180;
end
angle2 = atand(pair2(1,1)/pair2(1,2));
if pair2(1,2)<0
	angle2 = angle2 + 180;
end



match_rotation = angle1 - angle2;
piece2 = rotatePiece(piece2, match_rotation);

pair2a = piece2.Corners(edge_2(1, 2), :);


dist1 = sqrt(sum(pair1.^2));
dist2 = sqrt(sum(pair2.^2));

if abs(dist1-dist2)>(edge_length_threshold*max(dist1,dist2))
	shape_match_score = inf;
	match_position = 0;
	return;
end




size1 = size(piece1.ImageBW);
size2 = size(piece2.ImageBW);
corr_r = size2(1,1);
corr_c = size2(1,2);
comparisonSpace = zeros(size1(1, 1)+ 2*size2(1, 1) + 5, size1(1, 2)+ 2*size2(1, 2) + 5);
comparisonSpace( ...
	corr_r + 1 : corr_r + size1(1,1), ...
	corr_c + 1 : corr_c + size1(1,2)) = piece1.ImageBW;

pair2a = piece2.Corners(edge_2(1, 2), :);
piece1Corner = [corr_r, corr_c] + pair1b;


insertionPoint = piece1Corner - pair2a;
comparisonSpace(insertionPoint(1,2):insertionPoint(1,2) + size2(1,2) - 1, insertionPoint(1,1):insertionPoint(1, 1) + size2(1,1) - 1) = ...
	xor(comparisonSpace(insertionPoint(1,2):insertionPoint(1,2) + size2(1,2) - 1, insertionPoint(1,1):insertionPoint(1,1) + size2(1,1) - 1), piece2.ImageBW);





% figure;
% imshow(comparisonSpace);
% hold on;
% plot(corr_r, corr_c, 'or', 'MarkerSize', 10);
% plot(piece1Corner(1, 1), piece1Corner(1, 2), 'ob', 'MarkerSize', 10);
% plot(insertionPoint(1, 1), insertionPoint(1, 2), 'ob', 'MarkerSize', 10);



mask = ones(fit_mask_width, round(max(dist1,dist2)))';
mask = boolean(bufferImage(mask));

mask_piece = puzzlePiece(mask);
mask_piece.ImageBW = mask;
mask_piece.ImageRGB = mask;
mask_piece = find_corner(mask_piece);

mask_piece = rotatePiece(mask_piece, angle1);

maskCorner1 = mask_piece.Corners(1, :);
maskCorner4 = mask_piece.Corners(2, :);
maskCenter = round((maskCorner1 + maskCorner4)/2);
insertionPoint = piece1Corner - maskCenter;
maskSize = size(mask_piece.ImageBW);

maskComparisonSpace = zeros(size1(1, 1)+ 2*size2(1, 1) + 5, size1(1, 2)+ 2*size2(1, 2) + 5);
maskComparisonSpace( ...
	insertionPoint(1,2) + 1 : insertionPoint(1,2) + maskSize(1,2), ...
	insertionPoint(1,1) + 1 : insertionPoint(1,1) + maskSize(1,1)) = mask_piece.ImageBW;

maskComparisonSpace = and(maskComparisonSpace, not(comparisonSpace));

shape_match_score = sum(sum(maskComparisonSpace));



end




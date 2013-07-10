function [rotated_piece] = rotatePiece(piece_to_rotate, angle)

rotated_piece = puzzlePiece(piece_to_rotate.Image);
rotated_piece.Image = imrotate(piece_to_rotate.Image, angle, 'nearest', 'crop');
rotated_piece.ImageRGB = imrotate(piece_to_rotate.ImageRGB, angle, 'nearest', 'crop');
rotated_piece.ImageBW = imrotate(piece_to_rotate.ImageBW, angle, 'nearest', 'crop');

corners = piece_to_rotate.Corners;

for i = 1:4
	corners(i, :) = rotatePoint(corners(i, :), size(piece_to_rotate.Image)/2, angle);
end

rotated_piece.PositionInSolution = piece_to_rotate.PositionInSolution;
rotated_piece.Corners = corners;

end
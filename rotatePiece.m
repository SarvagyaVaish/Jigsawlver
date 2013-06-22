function [rotated_piece] = rotatePiece(piece_to_rotate, angle)

rotated_piece = puzzlePiece(imrotate(piece_to_rotate.Image, angle, 'nearest', 'crop'));
for i = 1:4
	rotated_piece.Corners(i, :) = rotatePoint(piece_to_rotate.Corners(i, :), size(piece_to_rotate.Image)/2, angle);
end

end
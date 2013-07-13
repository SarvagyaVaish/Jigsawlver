function shiftCorners(piece_index, number)
global pieces;

if mod(number,4)==0
	return;
end

pieces{piece_index}.Corners = [pieces{piece_index}.Corners((number + 1):4, :);...
	pieces{piece_index}.Corners(1:number, :)];

end
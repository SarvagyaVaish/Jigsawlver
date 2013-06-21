function [shape_match_score, match_position] = compare_edge_shape(edge_1, edge_2)

global pieces;

subplot(1, 2, 1);
imshow(pieces{edge_1(1, 1)}.Image)
edge_1(1, 2)
subplot(1, 2, 2);
imshow(pieces{edge_2(1, 1)}.Image)
edge_2(1, 2)

reply = questdlg(['Does the SHAPE match', num2str(edge_1(1, 2)), num2str(edge_2(1, 2))], '', 'Yes', 'No', 'No');

if strcmp(reply, 'No')
	shape_match_score = 1000;
elseif strcmp(reply, 'Yes')
	shape_match_score = 0;
else
	error('your quitting error message')
end

match_position = 0;

end
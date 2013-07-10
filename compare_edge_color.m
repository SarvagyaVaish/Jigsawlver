function [color_match_score] = compare_edge_color(edge_1, edge_2)

% global pieces;
% 
% subplot(1, 2, 1);
% imshow(pieces{edge_1(1, 1)}.Image)
% edge_1(1, 2)
% subplot(1, 2, 2);
% imshow(pieces{edge_2(1, 1)}.Image)
% edge_2(1, 2)
% 
% reply = questdlg(['Does the COLOR match', num2str(edge_1(1, 2)), num2str(edge_2(1, 2))], '', 'Yes', 'No', 'No');
% 
% if strcmp(reply, 'No')
% 	color_match_score = 1000;
% elseif strcmp(reply, 'Yes')
% 	color_match_score = 0;
% else
% 	error('your quitting error message')
% end

color_match_score = 0;

end
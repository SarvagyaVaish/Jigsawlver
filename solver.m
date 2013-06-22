clc;clear;

% PARAMS
shape_match_score_threshold = 1;
color_match_score_threshold = 1;
shape_match_threshold_backoff = 1;
color_match_threshold_backoff = 1;

% Step 1: Blob detection
%   input: one giant image 3D
%   output: list of grayscale puzzle pieces

global pieces;
pieces = {};
path = 'puzzles/sky/piece_';
file_extension = '.PNG';
for i = 1:9
	filename = [path, num2str(i), file_extension];
	new_piece = im2double(rgb2gray(imread(filename)));
	pieces{end+1} = puzzlePiece(new_piece);
	
	tl = find_corner(filename, 'top_left');
	tr = find_corner(filename, 'top_right');
	bl = find_corner(filename, 'bottom_left');
	br = find_corner(filename, 'bottom_right');
	
	pieces{end}.Corners = [tl; tr; br; bl];
	
	%     subplot(3, 3, i);
	%     imshow(new_piece); hold on;
	%     plot(top_left_corner(1), top_left_corner(2), 'or', 'MarkerSize', 10);
	%     plot(top_right_corner(1), top_right_corner(2), 'or', 'MarkerSize', 10);
	%     plot(bottom_left_corner(1), bottom_left_corner(2), 'or', 'MarkerSize', 10);
	%     plot(bottom_right_corner(1), bottom_right_corner(2), 'or', 'MarkerSize', 10);
	
end


% Step 3: Graph search
%   input: all puzzle pieces
%   output: the solution


% relative position matrix
solution_matrix = zeros(4*length(pieces));
pieces{1}.PositionInSolution = [floor(length(solution_matrix)/2), floor(length(solution_matrix)/2)];
solution_matrix(floor(length(solution_matrix)/2), floor(length(solution_matrix)/2)) = 1;

% adding all edges of the first piece to the bfs search queue
edges_in_queue = [];
for edge_number = 1:4
	edges_in_queue(end+1, :) = [1, edge_number];
end

unmatched_edges = [];
for piece_number = 2:length(pieces)
	for edge_number = 1:4
		unmatched_edges(end+1, :) = [piece_number, edge_number];
	end
end

% list of edges which we would iterate over
% after lowering the threshold
edges_with_no_match = [];


while length(unmatched_edges)>0
	while length(edges_in_queue)>0 && length(unmatched_edges)>0
		edge_to_be_checked = edges_in_queue(1, :);
		edges_in_queue(1, :) = [];
		
		best_unmatched_edge_index = inf;
		best_unmatched_edge_score = inf;
		position_of_best_unmatched_edge = 0;
        rotation_of_best_unmatched_edge = 0;
		
		for unmatched_edge_index = 1:size(unmatched_edges, 1)
			% Compare edge shapes
			[shape_match_score, match_position, match_rotation] = compare_edge_shape( ...
				edge_to_be_checked, unmatched_edges(unmatched_edge_index, :));
			
			if shape_match_score < shape_match_score_threshold
				% Compare edge colors
				[color_match_score] = compare_edge_color( ...
					edge_to_be_checked, unmatched_edges(unmatched_edge_index, :), match_position);
				
				if color_match_score < color_match_score_threshold
					% calculate overall score
					unmatched_edge_score = color_match_score + shape_match_score;
					if unmatched_edge_score < best_unmatched_edge_score
						best_unmatched_edge_score  = unmatched_edge_score;
						best_unmatched_edge_index = unmatched_edge_index;
						position_of_best_unmatched_edge = match_position;
					end
				end
				
			end
			
		end
		
		% now we have the best piece if best_unmatched_edge_score ~= inf
		if best_unmatched_edge_score ~= inf
			position = pieces{edge_to_be_checked(1,1)}.PositionInSolution;
			switch(edge_to_be_checked(1,2))
				case 1
					position(1,1) = position(1,1) - 1;
				case 2
					position(1,2) = position(1,2) + 1;
				case 3
					position(1,1) = position(1,1) + 1;
				case 4
					position(1,2) = position(1,2) - 1;
			end
			pieces{unmatched_edges(best_unmatched_edge_index,1)}.PositionInSolution = position;
			pieces{unmatched_edges(best_unmatched_edge_index,1)} = rotatePiece(pieces{unmatched_edges(best_unmatched_edge_index,1)}, rotation_of_best_unmatched_edge);
            
			solution_matrix(position(1,1),position(1,2)) = unmatched_edges(best_unmatched_edge_index,1);
			if(solution_matrix(position(1,1)+1,position(1,2)) == 0)
				edges_in_queue(end+1,:) = [unmatched_edges(best_unmatched_edge_index,1),3]
			else
				ind_to_delete = find(edges_in_queue(:, 1) == unmatched_edges(best_unmatched_edge_index,1) ...
				& edges_in_queue(:, 2) == 1)
				edges_in_queue(ind_to_delete, :) = [];
			end
			
			if(solution_matrix(position(1,1)-1,position(1,2)) == 0)
				edges_in_queue(end+1,:) = [unmatched_edges(best_unmatched_edge_index,1),1]
			else
				ind_to_delete = find(edges_in_queue(:, 1) == unmatched_edges(best_unmatched_edge_index,1) ...
				& edges_in_queue(:, 2) == 3)
				edges_in_queue(ind_to_delete, :) = [];
			end
			
			if(solution_matrix(position(1,1),position(1,2)+1) == 0)
				edges_in_queue(end+1,:) = [unmatched_edges(best_unmatched_edge_index,1),2]
			else
				ind_to_delete = find(edges_in_queue(:, 1) == unmatched_edges(best_unmatched_edge_index,1) ...
				& edges_in_queue(:, 2) == 4)
				edges_in_queue(ind_to_delete, :) = [];
			end
			
			if(solution_matrix(position(1,1),position(1,2)-1) == 0)
				edges_in_queue(end+1,:) = [unmatched_edges(best_unmatched_edge_index,1),4]
			else
				ind_to_delete = find(edges_in_queue(:, 1) == unmatched_edges(best_unmatched_edge_index,1) ...
				& edges_in_queue(:, 2) == 2)
				edges_in_queue(ind_to_delete, :) = [];
			end
			
			ind = find(unmatched_edges(:,1) == unmatched_edges(best_unmatched_edge_index,1));
			unmatched_edges(ind, :) = [];
			
		else
			edges_with_no_match(end+1, :) = edge_to_be_checked;
		end
		
	end
	
	%backoff on threshold
	shape_match_score_threshold = shape_match_score_threshold + shape_match_threshold_backoff;
	color_match_score_threshold = color_match_score_threshold + color_match_threshold_backoff;
end



% solution = random piece
% initialize each side of piece to null
% for each null side in solution
%   find
% iterate over all side of other pieces




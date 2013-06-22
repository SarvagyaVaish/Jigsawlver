function piece = find_corner(piece)
warning('off');

% get piece
piece_image = piece.Image;
[rows, cols] = size(piece_image);

% get binary
piece_image_binary = piece.ImageBW;

corners = [];
for corner_type_cell = {'top_left', 'top_right', 'bottom_right', 'bottom_left'}
	
	corner_type = corner_type_cell{1};
	% form wavelet
	wavelet_size = 10;
	wavelet = boolean(ones(wavelet_size));
	switch (corner_type)
		case 'top_left'
			wavelet(1:wavelet_size/2, :) = false;
			wavelet(:, 1:wavelet_size/2) = false;
			image_corner = [1, 1];
		case 'top_right'
			wavelet(1:wavelet_size/2, :) = false;
			wavelet(:, wavelet_size/2+1:end) = false;
			image_corner = [cols, 1];
		case 'bottom_left'
			wavelet(wavelet_size/2+1:end, :) = false;
			wavelet(:, 1:wavelet_size/2) = false;
			image_corner = [1, rows];
		case 'bottom_right'
			wavelet(wavelet_size/2+1:end, :) = false;
			wavelet(:, wavelet_size/2+1:end) = false;
			image_corner = [cols, rows];
	end
	
	% find wavelet in piece_image
	score_map = ones(rows, cols)*power(wavelet_size, 2);
	
	for x = 1:rows-wavelet_size
		for y = 1:cols-wavelet_size
			
			piece_image_section = piece_image_binary(x:x+wavelet_size-1, y:y+wavelet_size-1);
			dist_mat = xor(piece_image_section, wavelet);
			
			error = sum(sum(dist_mat));
			score_map(x+wavelet_size/2, y+wavelet_size/2) = error;
			
			% visualize with time delay
			%         [x, y, error]
			%         subplot(1, 3, 1);
			%         imshow(mat2gray(piece_image_section, [min(min(piece_image_section)), max(max(piece_image_section))]));
			%         subplot(1, 3, 2);
			%         imshow(mat2gray(wavelet, [min(min(wavelet)), max(max(wavelet))]));
			%         subplot(1, 3, 3);
			%         imshow(mat2gray(dist_mat, [min(min(dist_mat)), max(max(dist_mat))]));
			%         pause(0.0001);
		end
	end
	
	% find local minimum errors
	%imagesc(score_map);
	
	% find local areas of interest
	top_percent = 0.10;
	error_thresh = (max(max(score_map))-min(min(score_map)))*top_percent;
	local_best_areas = score_map;
	local_best_areas(local_best_areas <= error_thresh) = true;
	local_best_areas(local_best_areas > error_thresh) = false;
	local_best_areas = boolean(local_best_areas);
	local_best_areas = imfill(local_best_areas, 'holes');
	
	% blob detection
	local_best_areas = bwlabel(local_best_areas, 8);
	possible_corners = [];
	for area = 1:max(unique(local_best_areas))
		indices = find(local_best_areas == area);
		[a, corner_index] = min(score_map(indices));
		corner_index = indices(corner_index);
		corner_col = mod(corner_index, rows);
		corner_row = double(int64(corner_index./rows)) + 1;
		possible_corners(end+1, :) = [corner_row, corner_col];
	end
	
	%possible_corners
	
	% select corner closest to image corner
	min_dist = pdist([possible_corners(1, :); image_corner]);
	corner_index = 1;
	for corner = 2:size(possible_corners, 1)
		curr_dist = pdist([possible_corners(corner, :); image_corner]);
		if curr_dist < min_dist
			min_dist = curr_dist;
			corner_index = corner;
		end
	end
	
	corner_location = possible_corners(corner_index, :);
	
	corners(end+1, :) = corner_location;
end

piece.Corners = corners;

end
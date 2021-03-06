function piece = find_corner(piece)
warning('off');

% params
wavelet_size_param = 1/15;
top_percent = 0.95;

% get piece
piece_image = piece.Image;
[rows, cols] = size(piece_image);

wavelet_size = 2*round(min(size(piece.Image)) * wavelet_size_param);

% get binary
piece_image_binary = piece.ImageBW;

possible_corners = [];
for corner_type_cell = {'bottom_right', 'top_right', 'top_left', 'bottom_left'}
	
	corner_type = corner_type_cell{1};
	% form wavelet
	wavelet = boolean(ones(wavelet_size));
	switch (corner_type)
		case 'top_left'
			wavelet(1:wavelet_size/2, :) = false;
			wavelet(:, 1:wavelet_size/2) = false;
		case 'top_right'
			wavelet(1:wavelet_size/2, :) = false;
			wavelet(:, wavelet_size/2+1:end) = false;
		case 'bottom_left'
			wavelet(wavelet_size/2+1:end, :) = false;
			wavelet(:, 1:wavelet_size/2) = false;
		case 'bottom_right'
			wavelet(wavelet_size/2+1:end, :) = false;
			wavelet(:, wavelet_size/2+1:end) = false;
	end
	
	% find wavelet in piece_image
	score_map = ones(rows, cols)*power(wavelet_size, 2);
	
	for x = 1:rows-wavelet_size
		for y = 1:cols-wavelet_size
			
			piece_image_section = piece_image_binary(x:x+wavelet_size-1, y:y+wavelet_size-1);
			dist_mat = xor(piece_image_section, wavelet);
			
			error = sum(sum(dist_mat));
			score_map(x+wavelet_size/2, y+wavelet_size/2) = error;
		end
	end
	
	% find local minimum errors
	%imagesc(score_map);
	%summed_score_map = summed_score_map + score_map.^8;
	
	% find local areas of interest
	
	score_map = score_map(wavelet_size/2+1:end-wavelet_size/2, wavelet_size/2+1:end-wavelet_size/2);
	local_best_areas = score_map;
	
	%hist(reshape(score_map, 1, size(score_map, 1)*size(score_map, 2)));
	
	%error_thresh = max(max(score_map)) - (max(max(score_map)) - min(min(score_map))) * top_percent;
	error_thresh = wavelet_size^2-top_percent*wavelet_size^2;
	%local_best_areas = score_map;
	true_ind = find(local_best_areas <= error_thresh);
	false_ind = find(local_best_areas > error_thresh);
	local_best_areas(true_ind) = true;
	local_best_areas(false_ind) = false;
	local_best_areas = imfill(local_best_areas, 'holes');
	
	% blob detection
	[r, c] = size(local_best_areas);
	local_best_areas = bwlabel(local_best_areas, 8);
	for area = 1:max(unique(local_best_areas))
		indices = find(local_best_areas == area);
		[a, corner_index] = min(score_map(indices));
		corner_index = indices(corner_index);
		corner_col = mod(corner_index, r);
		corner_row = double(int64(corner_index./r));
		possible_corners(end+1, :) = [corner_row, corner_col];
	end
	
	possible_corners;
	
end

possible_corners = possible_corners + wavelet_size/2;

numCorn = length(possible_corners);
if numCorn<4
    piece.show_image
    possible_corners
end
bestCorners = possible_corners(1:4, :);
bestArea = 0;
for h=1:numCorn
    for i=1:numCorn
        if i == h
            continue;
        end
        for j=1:numCorn
           if j == h || j == i
               continue;
           end
           for k=1:numCorn
               if k == h || k == i || k == j
                   continue;
               end
                  checkCorners = [possible_corners(h,:);possible_corners(i,:);possible_corners(j,:);possible_corners(k,:)];

                binSize = size(piece_image_binary);
                shape = poly2mask(checkCorners(:,1)',checkCorners(:,2)',binSize(1,1), binSize(1,2));
                overlap = not(xor(shape, piece_image_binary));

                checkArea = sum(sum(overlap));

                if checkArea>bestArea
                   bestArea = checkArea;
                   bestCorners = checkCorners;
                end
           end
        end
    end    
end

piece.Corners = bestCorners;

end
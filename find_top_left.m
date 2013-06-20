function find_top_left(filename, sbplt_x, sbplt_y, plt_index)

% get piece
original_piece = imread(filename);
piece = im2double(rgb2gray(original_piece));
[rows, cols] = size(piece);

% convert to binary
piece_binary = boolean(im2bw(piece, graythresh(piece)));
piece_binary = imfill(~piece_binary, 'holes');

% form wavelet - see matlab wavelets
wavelet_size = 10;
top_left_wavelet = boolean(ones(wavelet_size));
top_left_wavelet(1:wavelet_size/2, :) = false;
top_left_wavelet(:, 1:wavelet_size/2) = false;

% find wavelet in piece
score_map = ones(rows, cols)*power(wavelet_size, 2);

warning('off');

for x = 1:rows-wavelet_size
    for y = 1:cols-wavelet_size
        
        piece_section = piece_binary(x:x+wavelet_size-1, y:y+wavelet_size-1);
        dist_mat = xor(piece_section, top_left_wavelet);
        
        error = sum(sum(dist_mat));
        score_map(x+wavelet_size/2, y+wavelet_size/2) = error;
        
        % visualize with time delay
        %         [x, y, error]
        %         subplot(1, 3, 1);
        %         imshow(mat2gray(piece_section, [min(min(piece_section)), max(max(piece_section))]));
        %         subplot(1, 3, 2);
        %         imshow(mat2gray(top_left_wavelet, [min(min(top_left_wavelet)), max(max(top_left_wavelet))]));
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
image_corner = [0, 0];
min_dist = pdist([possible_corners(1, :); image_corner]);
corner_index = 1;
for corner = 2:size(possible_corners, 1)
    curr_dist = pdist([possible_corners(corner, :); image_corner]);
    if curr_dist < min_dist
        min_dist = curr_dist;
        corner_index = corner;
    end
end

corner = possible_corners(corner_index, :);

subplot(sbplt_x, sbplt_y, plt_index);
imshow(original_piece); hold on;
plot(corner(1), corner(2), 'or', 'MarkerSize', 10);

end
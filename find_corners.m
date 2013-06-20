clear; clc;

% get piece
piece = im2double(rgb2gray(imread('puzzles/sky/piece_3.PNG')))

% convert to binary
piece_binary = boolean(im2bw(piece, graythresh(piece)));
piece_binary = imfill(~piece_binary, 'holes');

% form wavelet - see matlab wavelets
wavelet_size = 10;
top_left_wavelet = ones(wavelet_size)*1.0;
top_left_wavelet(1:wavelet_size/2, :) = 0.;
top_left_wavelet(:, 1:wavelet_size/2) = 0.;

% find wavelet in piece
[rows, cols] = size(piece_binary);
score_map = zeros(rows-wavelet_size, cols-wavelet_size);

warning('off');

for x = 1:rows-wavelet_size
    for y = 1:cols-wavelet_size
        
        piece_section = piece_binary(x:x+wavelet_size-1, y:y+wavelet_size-1);
        dist_mat = power( (piece_section - top_left_wavelet), 2);
        
        error = sum(sum(dist_mat));
        score_map(x, y) = error;
         
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

% find the points with lowest error using percentage
top_percent = 0.05;
[m, n] = size(score_map);
score_map_lin = reshape(score_map, m*n, 1);
error_thresh = (max(score_map_lin)-min(score_map_lin))*top_percent

score_map(score_map <= error_thresh) = 0;
score_map(score_map > error_thresh) = 1;

subplot(1, 1, 1);
imshow(mat2gray(score_map, [min(min(score_map)), max(max(score_map))]));



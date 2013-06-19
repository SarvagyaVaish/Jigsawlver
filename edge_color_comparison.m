clc;clear;

pieces_filenames = { ...
    'puzzles/square_pieces/piece_1.jpg', ...
    'puzzles/square_pieces/piece_2.jpg', ...
    'puzzles/square_pieces/piece_3.jpg', ...
    'puzzles/square_pieces/piece_4.jpg' ...
    };

% create a list of all pieces
pieces = {};
for piece_filename = pieces_filenames
    new_piece = im2double(rgb2gray(imread(piece_filename{1})));
    pieces{end+1} = puzzlePiece(new_piece);
end


% solution = random piece
% initialize each side of piece to null
% for each null side in solution
%   find 
% iterate over all side of other pieces




clc;clear;

% Step 1: Blob detection
%   input: one giant image 3D
%   output: list of grayscale puzzle pieces

pieces = {};
path = 'puzzles/sky/piece_';
file_extension = '.PNG';
for i = 1:9
    filename = [path, num2str(i), file_extension];
    new_piece = im2double(rgb2gray(imread(filename)));
    pieces{end+1} = puzzlePiece(new_piece);
end

% Step 2: Find corners using Hough's Transform
%   input: one puzzle piece
%   output: adding corner data to the puzzle piece object

% Step 3: Graph search 
%   input: all puzzle pieces
%   output: the solution



% solution = random piece
% initialize each side of piece to null
% for each null side in solution
%   find 
% iterate over all side of other pieces




function [color_match_score] = compare_edge_color(edge_1, edge_2, rotation)
% PARAMS
comparison_depth = 14;
num_points = 50;

global pieces;

piece1 = pieces{edge_1(1, 1)};
piece2 = rotatePiece(pieces{edge_2(1, 1)}, rotation);

pair1a = piece1.Corners(edge_1(1, 2), :);
pair1b = piece1.Corners(mod(edge_1(1, 2), 4) + 1, :);
pair2b = piece2.Corners(edge_2(1, 2), :);
pair2a = piece2.Corners(mod(edge_2(1, 2), 4) + 1, :);

size1 = size(piece1.Image);
size2 = size(piece2.Image);
corr_r = size2(1,1);
corr_c = size2(1,2);
comparisonSpace = zeros(size1(1, 1)+ 2*size2(1, 1) + 5, size1(1, 2)+ 2*size2(1, 2) + 5);
comparisonSpace( ...
	corr_r + 1 : corr_r + size1(1,1), ...
	corr_c + 1 : corr_c + size1(1,2)) = piece1.Image;

piece1Corner = [corr_r, corr_c] + pair1b;
insertionPoint = piece1Corner - pair2b;

comparisonSpace(insertionPoint(1,2):insertionPoint(1,2) + size2(1,2) - 1, insertionPoint(1,1):insertionPoint(1, 1) + size2(1,1) - 1) = ...
    comparisonSpace(insertionPoint(1,2):insertionPoint(1,2) + size2(1,2) - 1, insertionPoint(1,1):insertionPoint(1, 1) + size2(1,1) - 1) + piece2.Image;

% close all;
% figure;
% imagesc(comparisonSpace);
% hold on;

pairA = round(((pair1a + [corr_r, corr_c]) + (pair2a + insertionPoint))/2);
pairB = ((pair1b + [corr_r, corr_c]) + (pair2b + insertionPoint))/2;
pathVector = pairB - pairA;

% test = (pair1a + [corr_r, corr_c]);
% plot(test(1, 1), test(1, 2), 'or', 'MarkerSize', 10);
% test = (pair2a + insertionPoint);
% plot(test(1, 1), test(1, 2), 'or', 'MarkerSize', 10);
% test = (pair1b + [corr_r, corr_c]);
% plot(test(1, 1), test(1, 2), 'or', 'MarkerSize', 10);
% test = (pair2b + insertionPoint);
% plot(test(1, 1), test(1, 2), 'or', 'MarkerSize', 10);



inverse = [pathVector(1,2), pathVector(1,1)];
offset = round(inverse * 4/sqrt(sum(inverse.^2)));
color_match_score = 0;

% imagesc(comparisonSpace);
% hold on;

for i=0:num_points
   spot = pairA + round(pathVector*i/num_points);
   a = spot + offset;
   b = spot - offset;
   
   aVal = comparisonSpace(a(1,2), a(1,1));
   bVal = comparisonSpace(b(1,2), b(1,1));
   color_match_score = color_match_score + (aVal - bVal)^2;
%    plot(a(1, 1), a(1, 2), 'or');
%    plot(b(1, 1), b(1, 2), 'or');
end

end
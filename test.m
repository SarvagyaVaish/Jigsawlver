clc;clear;
load('pieces.mat');
e1 = [1, 2];
e2 = [4, 4];
e3 = [5, 4];

[shape_match_score, match_rotation] = compare_edge_shape(e1, e2);
[color_match_score] = compare_edge_color( e1, e2, match_rotation);

color_match_score
subplot(2, 2, 1)
imshow(pieces{e1(1, 1)}.ImageRGB)
subplot(2, 2, 2)
p = rotatePiece(pieces{e2(1, 1)}, match_rotation);
imshow(p.ImageRGB)


[shape_match_score, match_rotation] = compare_edge_shape(e1, e3);
[color_match_score] = compare_edge_color( e1, e3, match_rotation);

color_match_score
subplot(2, 2, 3)
imshow(pieces{e1(1, 1)}.ImageRGB)
subplot(2, 2, 4)
p = rotatePiece(pieces{e3(1, 1)}, match_rotation);
imshow(p.ImageRGB)
clc;clear;
load('pieces.mat');

p_a = pieces{1};

edge_a = 2;
corners_a_ind = edge_a:edge_a+1;
corners_a_ind(corners_a_ind == 5) = 1;

corners_a = p_a.Corners(corners_a_ind, :)
m_a = twoPointSlope(corners_a(1, :), corners_a(2, :))
(atand(m_a))

subplot(1, 2, 1);
hold on;
imshow(p_a.Image)
plot(corners_a(1, 1), corners_a(1, 2), 'or', 'MarkerSize', 10);
plot(corners_a(2, 1), corners_a(2, 2), 'or', 'MarkerSize', 10);

subplot(1, 2, 2);
hold on;
p_a.show_image;
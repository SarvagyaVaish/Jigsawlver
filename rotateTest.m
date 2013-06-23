clc;
ang = 15;

p = rotatePiece(pieces{1}, ang);
subplot(1, 3, 1)
pieces{1}.show_image
subplot(1, 3, 2)
p.show_image

subplot(1, 3, 3)
hold on;
for i = 2:2
	point = pieces{1}.Corners(i, :);
	'point'; point
	plot(point(1), point(2), 'ok');
	rp = rotatePoint(point, center, ang);
	'rp'; rp
	plot(rp(1), rp(2), 'xr');
end
center = size(pieces{1}.Image)./2;

%plot([0, 0, 20, 20], [0, 20, 0, 20], '.r');

plot(center(1), center(2), '.k');


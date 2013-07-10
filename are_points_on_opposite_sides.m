function boolean_answer = are_points_on_opposite_sides(p1, p2, linep1, linep2)
% http://math.stackexchange.com/questions/162728/how-to-determine-if-2-points-are-on-opposite-sides-of-a-line

ax = p1(1, 1);
ay = p1(1, 2);
bx = p2(1, 1);
by = p2(1, 2);
x1 = linep1(1, 1);
y1 = linep1(1, 2);
x2 = linep2(1, 1);
y2 = linep2(1, 2);

val = ((y1-y2).*(ax-x1)+(x2-x1).*(ay-y1)).*((y1-y2).*(bx-x1)+(x2-x1).*(by-y1));

if val < 0
	boolean_answer = true;
else
	boolean_answer = false;
end

end
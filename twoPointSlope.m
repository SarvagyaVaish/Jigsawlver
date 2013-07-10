function [m] = twoPointSlope(p1, p2)
	
m = (p2(2) - p1(2)) / (p2(1) - p1(1));

end
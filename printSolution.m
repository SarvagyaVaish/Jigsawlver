clc;
%close all;
sm = solution_matrix(17:20, 18:20);
sm_size = size(sm);
global pieces

f = figure
for i = 1:sm_size(1, 1)
	for j = 1:sm_size(1, 2)
		[i, j, sm(i, j)]
		if sm(i, j) ~= 0
			lin_ind = (i-1)*sm_size(1, 2) + j
			subplot(sm_size(1, 1), sm_size(1, 2), lin_ind)
			imshow(pieces{sm(i, j)}.ImageRGB)
		end
	end
end
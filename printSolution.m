function printSolution(solution_matrix)

sm = solution_matrix;
cols = find(sum(sm, 1) == 0);
sm(:, cols) = [];
rows = find(sum(sm, 2) == 0);
sm(rows, :) = [];

sm_size = size(sm);
global pieces

for i = 1:sm_size(1, 1)
	for j = 1:sm_size(1, 2)
		[i, j, sm(i, j)];
		if sm(i, j) ~= 0
			lin_ind = (i-1)*sm_size(1, 2) + j;
			subplot(sm_size(1, 1), sm_size(1, 2), lin_ind);
			imshow(pieces{sm(i, j)}.ImageRGB);
		end
	end
end

end
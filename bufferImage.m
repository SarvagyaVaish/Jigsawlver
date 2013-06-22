function [output_image] = bufferImage(input_image)

[r, c, w] = size(input_image);
diag = ceil(sqrt(r*r + c*c)) + 10;
output_image = uint8(zeros(diag, diag, w));

loc = ceil([(diag - r)/2, (diag - c)/2]);

for i = 1:w
	output_image( loc(1)+1:loc(1) + r, loc(2)+1:loc(2) + c, i) = input_image(:, :, i);
end
end
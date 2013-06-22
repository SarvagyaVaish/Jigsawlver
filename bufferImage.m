function [output_image] = bufferImage(input_image)

if size(input_image, 3) > 1
	input_image = im2double(rgb2gray(input_image));
end

[r, c] = size(input_image);
diag = ceil(sqrt(r*r + c*c)) + 10;
output_image = zeros(diag);

loc = ceil([(diag - r)/2, (diag - c)/2]);

output_image( loc(1)+1:loc(1) + r, loc(2)+1:loc(2) + c) = input_image;

end
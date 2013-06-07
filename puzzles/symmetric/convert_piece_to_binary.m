thresh = 180;

i = imread('piece_2.jpg');
i(i >= thresh) = 255;
i(i < thresh) = 0;
figure
imshow(i)

imwrite(i, 'piece_2.jpg');
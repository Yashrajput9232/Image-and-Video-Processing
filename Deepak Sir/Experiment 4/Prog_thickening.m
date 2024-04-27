clear all
clc

% Define a 2D array with zeros
a = zeros(9,10);
a(4:4,1:10) = 1; % Create a horizontal line at the 4th row

subplot(221)
imshow(a)
title('Original Image')

% Apply the 'thicken' morphological operation
b = bwmorph(a, 'thicken', 1);

subplot(222)
imshow(b)
title('Thicken Image')

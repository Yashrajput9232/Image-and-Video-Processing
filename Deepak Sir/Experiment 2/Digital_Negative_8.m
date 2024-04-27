% Clearing previous variables and figures
clear all;

% Read the image
original_image = imread('cameraman.tif');

% Define the maximum intensity value for an 8-bit image
max_intensity = 255;
max_intensity_uint8 = uint8(max_intensity);

% Invert the image by subtracting each pixel value from the maximum intensity
inverted_image = max_intensity_uint8 - original_image;

% Display the original image
subplot(2,2,1);
colormap(gray);
imagesc(original_image);
title('Original Image');

% Display the inverted image
subplot(2,2,2);
colormap(gray);
imagesc(inverted_image);
title('Inverted Image');

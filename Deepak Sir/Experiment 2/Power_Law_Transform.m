% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('pout.tif');
original_image = double(original_image); % Convert image to double for calculations

% Get the size of the image
[row, col] = size(original_image);

% Prompt user to enter the correction factor
gamma = input("Enter the correction factor: ");

% Perform power transformation
for x = 1:row
    for y = 1:col
        transformed_image(x, y) = original_image(x, y) ^ gamma;
    end
end

% Calculate the maximum and minimum values of the transformed image
max_val = max(max(transformed_image));
min_val = min(min(transformed_image));

% Perform normalization
scale_factor = 255 / (max_val - min_val);
for i = 1:row
    for j = 1:col
        normalized_image(i, j) = scale_factor * (transformed_image(i, j) - min_val);
    end
end

% Convert the normalized image to uint8 for display
final_image = uint8(normalized_image);

% Display the original and transformed images
subplot(1,2,1)
imshow(uint8(original_image))
title("Original Image")

subplot(1,2,2)
imshow(final_image)
title("Image after Power Transformation")

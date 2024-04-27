%% Grey Level Slicing with Background %%

% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('cameraman.tif');
original_image = double(original_image); % Convert image to double for calculations

% Get the size of the image
[row, col] = size(original_image);

% Define the threshold values for grey level slicing
low_threshold = 50;
high_threshold = 150;

% Perform grey level slicing with background
for x = 1:row
    for y = 1:col
        if (original_image(x, y) > low_threshold) && (original_image(x, y) < high_threshold)
            % If pixel intensity is within the threshold range, set to maximum intensity
            sliced_image(x, y) = 255;
        else
            % Otherwise, retain the original pixel intensity
            sliced_image(x, y) = original_image(x, y);
        end
    end
end

% Display the original image
subplot(1,2,1)
imshow(uint8(original_image));
title('Original Image');

% Display the image after grey level slicing with background
subplot(1,2,2)
imshow(uint8(sliced_image));
title('Grey Level Slicing with Background');

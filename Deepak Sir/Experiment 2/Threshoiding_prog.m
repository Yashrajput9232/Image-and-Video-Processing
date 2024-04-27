% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('cameraman.tif');

% Get the size of the image
[row, col] = size(original_image);

% Prompt user to enter the threshold value
T = input("Enter value of Threshold: ");

% Perform thresholding
for x = 1:row
    for y = 1:col
        if original_image(x, y) < T
            % If pixel intensity is below threshold, set to 0
            thresholded_image(x, y) = 0;
        else
            % If pixel intensity is above threshold, set to 255
            thresholded_image(x, y) = 255;
        end
    end
end

% Display the original image
subplot(1,2,1)
imshow(original_image);
title('Original Image');

% Display the thresholded image
subplot(1,2,2)
imshow(thresholded_image);
title('Thresholded Image');

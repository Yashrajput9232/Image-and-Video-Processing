%% Median Filter on Image with Salt and Pepper Noise %%

% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('pout.tif');
original_image_noisy = imnoise(original_image, 'gaussian');

% Add salt and pepper noise to the image
noisy_image = imnoise(original_image_noisy, 'salt & pepper', 0.02);

% Convert the noisy image to double
a = double(noisy_image);
b = a;

% Get the size of the image
[row, col] = size(a);

% Apply the median filter
for x = 2:row-1
    for y = 2:col-1
        % Extract a 3x3 neighborhood
        neighborhood = [a(x-1,y-1), a(x-1,y), a(x-1,y+1), a(x,y-1), a(x,y), a(x,y+1), a(x+1,y-1), a(x+1,y), a(x+1,y+1)];
        % Sort the values
        sorted_neighborhood = sort(neighborhood);
        % Get the median value
        median_value = sorted_neighborhood(5);
        % Update the pixel with the median value
        b(x,y) = median_value;
    end
end

% Displaying the original image, image with salt and pepper noise, and image after median filter
figure(1)
subplot(1,3,1)
imshow(uint8(original_image))
title('Original Image');

subplot(1,3,2)
imshow(uint8(original_image_noisy))
title('Image with Salt & Pepper Noise');

subplot(1,3,3)
imshow(uint8(b))
title('Image After Median Filter');

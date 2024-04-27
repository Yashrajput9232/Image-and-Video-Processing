% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('pout.tif');
original_image_noisy = imnoise(original_image, 'gaussian');
a = double(original_image_noisy);

% Get the size of the image
[row, col] = size(a);

% Prompt user to enter the mask size
mask_size = input('Enter the mask size: ');

% Calculate the total number of elements in the mask
n = mask_size^2;

% Initialize the filter kernel with averaging weights
for i = 1:mask_size
    for j = 1:mask_size
        w(i,j) = 1 / n;
    end
end

% Initialize the filtered image
b = zeros(row, col);

% Copy the border pixels from the original image
for x = 1:row
    for y = 1:col
        b(x,y) = a(x,y);
    end
end

% Zero out border pixels
s = (mask_size + 1) / 2;
for x = s:row-s+1
    for y = s:col-s+1
        b(x,y) = 0;
    end
end

% Apply the low-pass filter using convolution
for x = s:row-s+1
    for y = s:col-s+1
        for i = 1:mask_size
            for j = 1:mask_size
                b(x,y) = a(x-s+i, y-s+j) * w(i,j) + b(x,y);
            end
        end
    end
end

% Displaying the original image, image with noise, low-pass filtered image (averaging technique), and low-pass smoothed image using MATLAB's conv2 function
subplot(1,4,1)
imshow(uint8(original_image))
title('Original Image');
subplot(1,4,2)
imshow(uint8(original_image_noisy))
title('Image with Gaussian Noise');
subplot(1,4,3)
imshow(uint8(b))
title('Low Pass Filtered Image (Averaging Technique)');
% Using MATLAB's conv2 function for low-pass smoothing
c = conv2(a, w);
subplot(1,4,4)
imshow(uint8(c))
title('Low Pass Smoothing Filter using MATLAB');

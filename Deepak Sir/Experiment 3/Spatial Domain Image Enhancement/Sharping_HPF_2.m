%% High Pass Filtering of an Image %%

% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('xray2.tiff');
a = double(original_image);

% Get the size of the image
[row, col] = size(a);

% Prompt user to enter the mask size
mask_size = input('Enter the mask size: ');

% Initialize the filter kernel
w = -ones(mask_size);

% Center element of the kernel
s = (mask_size + 1) / 2;
w(s, s) = mask_size^2 - 1;

% Initialize the filtered image
b = zeros(row, col);

% Apply the high-pass filter
for x = 1:row
    for y = s:col
        % Copying border pixels
        b(x,y) = a(x,y);
    end
end

% Zero out border pixels
for x = s:row-s
    for y = s:col-s
        b(x,y) = 0;
    end
end

% Convolve the kernel with the image
for x = s:row-s
    for y = s:col-s
        for i = 1:mask_size
            for j = 1:mask_size
                b(x,y) = a(x-s+i, y-s+j) * w(i,j) + b(x,y);
            end
        end
        % Set negative values to zero
        if b(x,y) < 0
            b(x,y) = 0;
        end
    end
end

% Find the maximum pixel value
n = max(max(b));

% Normalize the image
c = 255 / n;
for x = s:row-s
    for y = s:col-s
        b(x,y) = c * b(x,y);
    end
end

% Displaying the original image and the high-pass filtered image
subplot(2,1,1)
imshow(uint8(a))
title('Original Image');

subplot(2,1,2)
imshow(uint8(b))
title('High Pass Filtered Image')

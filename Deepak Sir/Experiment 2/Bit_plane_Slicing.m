clear all;
clc;

% Read the image
image = imread('cameraman.tif');
image = double(image);

% Ask the user for bit selection
bit_index = input('Which bit image do you want to see? (1=MSB, 8=LSB): ');

% Validate user input
if bit_index < 1 || bit_index > 8
    error('Invalid bit index. Please enter a value between 1 and 8.');
end

% Extract the selected bit from each pixel
[row, col] = size(image);
extracted_bit_image = zeros(row, col);
for x = 1:row
    for y = 1:col
        % Convert pixel value to binary string
        binary_pixel = dec2bin(image(x, y), 8);
        % Extract the selected bit
        selected_bit = binary_pixel(bit_index);
        % Convert the selected bit back to integer (0 or 1)
        extracted_bit_image(x, y) = str2double(selected_bit);
    end
end

% Plot the original and extracted bit images
figure(1);
imshow(uint8(image));
title('Original Image');

figure(2);
imshow(uint8(extracted_bit_image * 255));
title(['Bit ', num2str(bit_index), ' Image']);
clear all;
clc;

% Read the image
image = imread('images.tiff');
image = double(image);

% Get the size of the image
[row, col] = size(image);

% Ask the user for bit selection
num_bits = 8;
bit_planes = cell(1, num_bits);
for bit_index = 1:num_bits
    % Extract the selected bit plane from each pixel
    bit_plane = zeros(row, col);
    for x = 1:row
        for y = 1:col
            % Convert pixel value to binary string
            binary_pixel = dec2bin(image(x, y), 8);
            % Extract the selected bit
            selected_bit = binary_pixel(bit_index);
            % Convert the selected bit back to integer (0 or 1)
            bit_plane(x, y) = str2double(selected_bit);
        end
    end
    % Store the bit plane
    bit_planes{bit_index} = bit_plane;
end

% Plot the original image and all the bit planes
figure;
subplot(num_bits + 1, 1, 1);
imshow(uint8(image));
title('Original Image');

 subplot(num_bits + 1, 1, 2);
    imshow(uint8(bit_planes{1} * 255));
    title('MSB');

for bit_index = 2:7
    subplot(num_bits + 1, 1, bit_index + 1);
    imshow(uint8(bit_planes{bit_index} * 255));
    title(['Bit Plane ', num2str(bit_index)]);
end

 subplot(num_bits + 1, 1, 8);
    imshow(uint8(bit_planes{8} * 255));
    title('LSB');
